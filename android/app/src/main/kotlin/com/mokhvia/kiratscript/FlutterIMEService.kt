package com.mokhvia.kiratscript

import android.inputmethodservice.InputMethodService
import android.view.View
import android.view.ViewGroup
import android.view.KeyEvent
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputConnection
import android.widget.FrameLayout
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.android.FlutterView
import io.flutter.plugin.common.MethodChannel
import android.media.AudioManager
import android.content.Context
import android.content.res.Configuration

class FlutterIMEService : InputMethodService() {
    companion object {
        private var sharedEngine: FlutterEngine? = null
    }

    private lateinit var flutterEngine: FlutterEngine
    private lateinit var flutterView: FlutterView
    private lateinit var channel: MethodChannel
    private val ENGINE_ID = "ime_engine"
    private val CHANNEL_NAME = "kirat_keyboard/ime"

    override fun onCreate() {
        super.onCreate()

        var engine = sharedEngine
        if (engine == null) {
            engine = FlutterEngine(applicationContext)
            val dartEntrypoint = DartExecutor.DartEntrypoint(
                FlutterInjector.instance().flutterLoader().findAppBundlePath(),
                "keyboardMain"
            )
            engine.dartExecutor.executeDartEntrypoint(dartEntrypoint)
            FlutterEngineCache.getInstance().put(ENGINE_ID, engine)
            sharedEngine = engine
        }
        flutterEngine = engine

        // Set up MethodChannel
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
        channel.setMethodCallHandler { call, result ->
            val ic: InputConnection? = currentInputConnection
            if (ic == null) {
                result.error("UNAVAILABLE", "InputConnection not available.", null)
                return@setMethodCallHandler
            }

            when (call.method) {
                "commitText" -> {
                    val text = call.argument<String>("text")
                    if (text != null) {
                        ic.commitText(text, 1)
                        result.success(null)
                    } else {
                        result.error("INVALID_ARGUMENT", "Text cannot be null", null)
                    }
                }
                "sendBackspace" -> {
                    ic.sendKeyEvent(KeyEvent(KeyEvent.ACTION_DOWN, KeyEvent.KEYCODE_DEL))
                    ic.sendKeyEvent(KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_DEL))
                    result.success(null)
                }
                "sendEnter" -> {
                    val action = currentInputEditorInfo?.imeOptions?.and(EditorInfo.IME_MASK_ACTION)
                    if (action != null && action != EditorInfo.IME_ACTION_NONE && action != EditorInfo.IME_ACTION_UNSPECIFIED) {
                        ic.performEditorAction(action)
                    } else {
                        ic.sendKeyEvent(KeyEvent(KeyEvent.ACTION_DOWN, KeyEvent.KEYCODE_ENTER))
                        ic.sendKeyEvent(KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_ENTER))
                    }
                    result.success(null)
                }
                "deleteSurroundingText" -> {
                    val beforeLength = call.argument<Int>("beforeLength") ?: 0
                    val afterLength = call.argument<Int>("afterLength") ?: 0
                    ic.deleteSurroundingText(beforeLength, afterLength)
                    result.success(null)
                }
                "playClickSound" -> {
                    val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                    // Check if system volume is not muted
                    if (audioManager.ringerMode != AudioManager.RINGER_MODE_SILENT) {
                        audioManager.playSoundEffect(AudioManager.FX_KEYPRESS_STANDARD)
                    }
                    result.success(null)
                }
                "performHapticFeedback" -> {
                    flutterView.performHapticFeedback(android.view.HapticFeedbackConstants.KEYBOARD_TAP)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private var cachedLayout: FrameLayout? = null

    override fun onCreateInputView(): View {
        if (cachedLayout == null) {
            val layout = layoutInflater.inflate(R.layout.keyboard_view, null) as FrameLayout
            val textureView = io.flutter.embedding.android.FlutterTextureView(this)
            flutterView = FlutterView(this, textureView)
            flutterView.attachToFlutterEngine(flutterEngine)
            flutterView.setBackgroundColor(android.graphics.Color.TRANSPARENT)
            cachedLayout = layout
        }

        val isLandscape = resources.configuration.orientation == Configuration.ORIENTATION_LANDSCAPE
        // 410f (340 keyboard + 70 popup space), 250f (180 keyboard + 70 popup space)
        val heightInDp = if (isLandscape) 250f else 410f

        val heightInPx = android.util.TypedValue.applyDimension(
            android.util.TypedValue.COMPLEX_UNIT_DIP, heightInDp, resources.displayMetrics
        ).toInt()

        val parent = flutterView.parent as? ViewGroup
        if (parent != null && parent != cachedLayout) {
            parent.removeView(flutterView)
        }

        if (flutterView.parent == null) {
            val params = FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                heightInPx
            )
            cachedLayout?.addView(flutterView, params)
        } else {
            flutterView.layoutParams = FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                heightInPx
            )
        }

        flutterEngine.lifecycleChannel.appIsResumed()
        return cachedLayout!!
    }

    override fun onWindowShown() {
        super.onWindowShown()
        // Wake up the Flutter render pipeline
        flutterEngine.lifecycleChannel.appIsResumed()
    }

    override fun onWindowHidden() {
        super.onWindowHidden()
        // Pause the Flutter render pipeline to save battery
        flutterEngine.lifecycleChannel.appIsPaused()
    }

    override fun onConfigureWindow(win: android.view.Window, isFullScreen: Boolean, isCandidatesOnly: Boolean) {
        super.onConfigureWindow(win, isFullScreen, isCandidatesOnly)
        win.setBackgroundDrawable(android.graphics.drawable.ColorDrawable(android.graphics.Color.TRANSPARENT))
    }

    override fun onComputeInsets(outInsets: android.inputmethodservice.InputMethodService.Insets) {
        super.onComputeInsets(outInsets)
        if (!isFullscreenMode) {
            val transparentTopDp = 70f
            val transparentTopPx = android.util.TypedValue.applyDimension(
                android.util.TypedValue.COMPLEX_UNIT_DIP, transparentTopDp, resources.displayMetrics
            ).toInt()

            outInsets.contentTopInsets = transparentTopPx
            outInsets.visibleTopInsets = transparentTopPx
            outInsets.touchableInsets = android.inputmethodservice.InputMethodService.Insets.TOUCHABLE_INSETS_VISIBLE
        }
    }

    override fun onDestroy() {
        if (::flutterView.isInitialized) {
            flutterView.detachFromFlutterEngine()
        }
        cachedLayout = null
        super.onDestroy()
    }
}
