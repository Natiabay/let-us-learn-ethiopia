package com.ethiopia.tourist.tourist_assistive_app

import android.content.Context
import android.speech.tts.TextToSpeech
import android.speech.tts.UtteranceProgressListener
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*

class VoiceServicePlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var context: Context? = null
    private var tts: TextToSpeech? = null
    private var isInitialized = false

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "voice_service")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "initialize" -> {
                initializeTTS(result)
            }
            "speakAmharic" -> {
                val text = call.argument<String>("text")
                if (text != null) {
                    speakAmharic(text, result)
                } else {
                    result.error("INVALID_ARGUMENT", "Text is required", null)
                }
            }
            "speakNative" -> {
                val text = call.argument<String>("text")
                val languageCode = call.argument<String>("languageCode")
                if (text != null && languageCode != null) {
                    speakNative(text, languageCode, result)
                } else {
                    result.error("INVALID_ARGUMENT", "Text and languageCode are required", null)
                }
            }
            "stopSpeaking" -> {
                stopSpeaking(result)
            }
            "setSpeechRate" -> {
                val rate = call.argument<Double>("rate")
                if (rate != null) {
                    setSpeechRate(rate.toFloat(), result)
                } else {
                    result.error("INVALID_ARGUMENT", "Rate is required", null)
                }
            }
            "setSpeechPitch" -> {
                val pitch = call.argument<Double>("pitch")
                if (pitch != null) {
                    setSpeechPitch(pitch.toFloat(), result)
                } else {
                    result.error("INVALID_ARGUMENT", "Pitch is required", null)
                }
            }
            "getAvailableLanguages" -> {
                getAvailableLanguages(result)
            }
            "isLanguageSupported" -> {
                val languageCode = call.argument<String>("languageCode")
                if (languageCode != null) {
                    isLanguageSupported(languageCode, result)
                } else {
                    result.error("INVALID_ARGUMENT", "LanguageCode is required", null)
                }
            }
            "dispose" -> {
                dispose(result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun initializeTTS(result: Result) {
        if (isInitialized) {
            result.success(true)
            return
        }

        tts = TextToSpeech(context) { status ->
            if (status == TextToSpeech.SUCCESS) {
                isInitialized = true
                result.success(true)
            } else {
                result.error("TTS_INIT_FAILED", "Failed to initialize TTS", null)
            }
        }
    }

    private fun speakAmharic(text: String, result: Result) {
        if (!isInitialized) {
            result.error("TTS_NOT_INITIALIZED", "TTS not initialized", null)
            return
        }

        try {
            // For Amharic, we'll use English TTS as fallback since Amharic TTS is limited
            val locale = Locale("en", "US")
            val ttsResult = tts?.setLanguage(locale)
            
            if (ttsResult == TextToSpeech.LANG_MISSING_DATA || ttsResult == TextToSpeech.LANG_NOT_SUPPORTED) {
                result.error("LANGUAGE_NOT_SUPPORTED", "Amharic language not supported", null)
                return
            }

            tts?.setOnUtteranceProgressListener(object : UtteranceProgressListener() {
                override fun onStart(utteranceId: String?) {
                    // Speech started
                }

                override fun onDone(utteranceId: String?) {
                    result.success(true)
                }

                override fun onError(utteranceId: String?) {
                    result.error("TTS_ERROR", "Error during speech", null)
                }
            })

            tts?.speak(text, TextToSpeech.QUEUE_FLUSH, null, "amharic_speech")
        } catch (e: Exception) {
            result.error("TTS_ERROR", "Error during Amharic speech: ${e.message}", null)
        }
    }

    private fun speakNative(text: String, languageCode: String, result: Result) {
        if (!isInitialized) {
            result.error("TTS_NOT_INITIALIZED", "TTS not initialized", null)
            return
        }

        try {
            val locale = when (languageCode) {
                "en" -> Locale("en", "US")
                "zh" -> Locale("zh", "CN")
                "fr" -> Locale("fr", "FR")
                "de" -> Locale("de", "DE")
                "es" -> Locale("es", "ES")
                "ar" -> Locale("ar", "SA")
                "pt" -> Locale("pt", "PT")
                "ru" -> Locale("ru", "RU")
                "ja" -> Locale("ja", "JP")
                else -> Locale("en", "US")
            }

            val ttsResult = tts?.setLanguage(locale)
            
            if (ttsResult == TextToSpeech.LANG_MISSING_DATA || ttsResult == TextToSpeech.LANG_NOT_SUPPORTED) {
                // Fallback to English if language not supported
                tts?.setLanguage(Locale("en", "US"))
            }

            tts?.setOnUtteranceProgressListener(object : UtteranceProgressListener() {
                override fun onStart(utteranceId: String?) {
                    // Speech started
                }

                override fun onDone(utteranceId: String?) {
                    result.success(true)
                }

                override fun onError(utteranceId: String?) {
                    result.error("TTS_ERROR", "Error during speech", null)
                }
            })

            tts?.speak(text, TextToSpeech.QUEUE_FLUSH, null, "native_speech")
        } catch (e: Exception) {
            result.error("TTS_ERROR", "Error during native speech: ${e.message}", null)
        }
    }

    private fun stopSpeaking(result: Result) {
        try {
            tts?.stop()
            result.success(true)
        } catch (e: Exception) {
            result.error("TTS_ERROR", "Error stopping speech: ${e.message}", null)
        }
    }

    private fun setSpeechRate(rate: Float, result: Result) {
        try {
            tts?.setSpeechRate(rate)
            result.success(true)
        } catch (e: Exception) {
            result.error("TTS_ERROR", "Error setting speech rate: ${e.message}", null)
        }
    }

    private fun setSpeechPitch(pitch: Float, result: Result) {
        try {
            tts?.setPitch(pitch)
            result.success(true)
        } catch (e: Exception) {
            result.error("TTS_ERROR", "Error setting speech pitch: ${e.message}", null)
        }
    }

    private fun getAvailableLanguages(result: Result) {
        try {
            val availableLanguages = tts?.availableLanguages?.map { it.toString() } ?: emptyList()
            result.success(availableLanguages)
        } catch (e: Exception) {
            result.error("TTS_ERROR", "Error getting available languages: ${e.message}", null)
        }
    }

    private fun isLanguageSupported(languageCode: String, result: Result) {
        try {
            val locale = when (languageCode) {
                "en" -> Locale("en", "US")
                "zh" -> Locale("zh", "CN")
                "fr" -> Locale("fr", "FR")
                "de" -> Locale("de", "DE")
                "es" -> Locale("es", "ES")
                "ar" -> Locale("ar", "SA")
                "pt" -> Locale("pt", "PT")
                "ru" -> Locale("ru", "RU")
                "ja" -> Locale("ja", "JP")
                else -> Locale("en", "US")
            }
            
            val ttsResult = tts?.setLanguage(locale)
            val isSupported = ttsResult != TextToSpeech.LANG_MISSING_DATA && ttsResult != TextToSpeech.LANG_NOT_SUPPORTED
            result.success(isSupported)
        } catch (e: Exception) {
            result.error("TTS_ERROR", "Error checking language support: ${e.message}", null)
        }
    }

    private fun dispose(result: Result) {
        try {
            tts?.stop()
            tts?.shutdown()
            tts = null
            isInitialized = false
            result.success(true)
        } catch (e: Exception) {
            result.error("TTS_ERROR", "Error disposing TTS: ${e.message}", null)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        tts?.shutdown()
    }
}













































