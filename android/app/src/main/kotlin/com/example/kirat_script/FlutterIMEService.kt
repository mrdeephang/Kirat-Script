package com.example.kirat_script

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
    private lateinit var flutterEngine: FlutterEngine
    private lateinit var flutterView: FlutterView
    private lateinit var channel: MethodChannel
    private val ENGINE_ID = "ime_engine"
    private val CHANNEL_NAME = "kirat_keyboard/ime"

    override fun onCreate() {
        super.onCreate()

        // Create a FlutterEngine
        flutterEngine = FlutterEngine(this)

        // Find the Dart entrypoint for the IME (we will create `keyboardMain` in Dart)
        val dartEntrypoint = DartExecutor.DartEntrypoint(
            FlutterInjector.instance().flutterLoader().findAppBundlePath(),
            "keyboardMain"
        )
        flutterEngine.dartExecutor.executeDartEntrypoint(dartEntrypoint)

        // Cache the engine
        FlutterEngineCache.getInstance().put(ENGINE_ID, flutterEngine)

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

    override fun onCreateInputView(): View {
        val layout = layoutInflater.inflate(R.layout.keyboard_view, null) as FrameLayout
        val textureView = io.flutter.embedding.android.FlutterTextureView(this)
        flutterView = FlutterView(this, textureView)
        flutterView.attachToFlutterEngine(flutterEngine)
        flutterEngine.lifecycleChannel.appIsResumed()

        flutterView.setBackgroundColor(android.graphics.Color.TRANSPARENT)

        val isLandscape = resources.configuration.orientation == Configuration.ORIENTATION_LANDSCAPE
        // 410f (340 keyboard + 70 popup space), 250f (180 keyboard + 70 popup space)
        val heightInDp = if (isLandscape) 250f else 410f

        val heightInPx = android.util.TypedValue.applyDimension(
            android.util.TypedValue.COMPLEX_UNIT_DIP, heightInDp, resources.displayMetrics
        ).toInt()

        val params = FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            heightInPx
        )
        layout.addView(flutterView, params)

        return layout
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

    override fun onDestroy() {
        flutterEngine.lifecycleChannel.appIsDetached()
        flutterView.detachFromFlutterEngine()
        FlutterEngineCache.getInstance().remove(ENGINE_ID)
        flutterEngine.destroy()
        super.onDestroy()
    }
}
