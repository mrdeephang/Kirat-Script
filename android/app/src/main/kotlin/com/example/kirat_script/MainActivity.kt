package com.example.kirat_script

import android.content.Context
import android.view.inputmethod.InputMethodManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "kirat_keyboard"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "insertText" -> {
                    // For now, we'll handle this in Flutter
                    // In a real system keyboard, you'd use InputConnection
                    result.success(null)
                }
                "deleteText" -> {
                    // For now, we'll handle this in Flutter
                    result.success(null)
                }
                "switchToSystemKeyboard" -> {
                    val imm = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
                    imm.showInputMethodPicker()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}