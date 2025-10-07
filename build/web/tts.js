// Web Text-to-Speech Implementation
// This file provides TTS functionality for the web platform

class WebTTS {
  constructor() {
    this.synth = window.speechSynthesis;
    this.voices = [];
    this.currentUtterance = null;
    this.isInitialized = false;
  }

  // Initialize TTS
  async initialize() {
    try {
      // Load voices
      this.voices = this.synth.getVoices();
      
      // If voices aren't loaded yet, wait for them
      if (this.voices.length === 0) {
        return new Promise((resolve) => {
          this.synth.onvoiceschanged = () => {
            this.voices = this.synth.getVoices();
            this.isInitialized = true;
            resolve();
          };
        });
      }
      
      this.isInitialized = true;
      console.log('WebTTS initialized with', this.voices.length, 'voices');
    } catch (error) {
      console.error('Failed to initialize WebTTS:', error);
    }
  }

  // Speak text in specified language
  async speak(text, languageCode = 'en') {
    if (!this.isInitialized) {
      await this.initialize();
    }

    try {
      // Stop any current speech
      this.stop();

      // Create utterance
      this.currentUtterance = new SpeechSynthesisUtterance(text);
      
      // Find appropriate voice for language
      const voice = this.findVoiceForLanguage(languageCode);
      if (voice) {
        this.currentUtterance.voice = voice;
      }

      // Set language
      this.currentUtterance.lang = this.getLanguageCode(languageCode);
      
      // Set speech parameters
      this.currentUtterance.rate = 0.9;
      this.currentUtterance.pitch = 1.0;
      this.currentUtterance.volume = 1.0;

      // Add event listeners
      this.currentUtterance.onstart = () => {
        console.log(`Started speaking ${languageCode}: ${text}`);
      };
      
      this.currentUtterance.onend = () => {
        console.log(`Finished speaking ${languageCode}: ${text}`);
        this.isSpeaking = false;
      };
      
      this.currentUtterance.onerror = (event) => {
        console.error('Speech synthesis error:', event.error);
        this.isSpeaking = false;
      };

      // Speak
      this.synth.speak(this.currentUtterance);
      this.isSpeaking = true;
      
      console.log(`Speaking ${languageCode}: ${text}`);
    } catch (error) {
      console.error('TTS Error:', error);
      this.isSpeaking = false;
    }
  }

  // Stop current speech
  stop() {
    if (this.synth.speaking) {
      this.synth.cancel();
    }
  }

  // Find voice for language
  findVoiceForLanguage(languageCode) {
    const langMap = {
      'en': 'en-US',
      'am': 'am-ET',
      'es': 'es-ES',
      'fr': 'fr-FR',
      'de': 'de-DE',
      'it': 'it-IT',
      'pt': 'pt-PT',
      'ru': 'ru-RU',
      'ja': 'ja-JP',
      'ko': 'ko-KR',
      'zh': 'zh-CN',
      'ar': 'ar-SA'
    };

    const targetLang = langMap[languageCode] || languageCode;
    
    // Try to find exact match
    let voice = this.voices.find(v => v.lang === targetLang);
    
    // If not found, try to find similar language
    if (!voice) {
      const langPrefix = targetLang.split('-')[0];
      voice = this.voices.find(v => v.lang.startsWith(langPrefix));
    }
    
    // Fallback to default voice
    if (!voice) {
      voice = this.voices.find(v => v.default) || this.voices[0];
    }

    return voice;
  }

  // Get proper language code
  getLanguageCode(languageCode) {
    const langMap = {
      'en': 'en-US',
      'am': 'am-ET',
      'es': 'es-ES',
      'fr': 'fr-FR',
      'de': 'de-DE',
      'it': 'it-IT',
      'pt': 'pt-PT',
      'ru': 'ru-RU',
      'ja': 'ja-JP',
      'ko': 'ko-KR',
      'zh': 'zh-CN',
      'ar': 'ar-SA'
    };

    return langMap[languageCode] || languageCode;
  }

  // Check if language is supported
  isLanguageSupported(languageCode) {
    const targetLang = this.getLanguageCode(languageCode);
    return this.voices.some(v => v.lang === targetLang || v.lang.startsWith(targetLang.split('-')[0]));
  }

  // Get available languages
  getAvailableLanguages() {
    const languages = new Set();
    this.voices.forEach(voice => {
      languages.add(voice.lang);
    });
    return Array.from(languages);
  }
}

// Create global instance
window.webTTS = new WebTTS();

// Export for use
if (typeof module !== 'undefined' && module.exports) {
  module.exports = WebTTS;
}
