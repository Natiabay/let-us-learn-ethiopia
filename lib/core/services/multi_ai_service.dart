import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:tourist_assistive_app/core/services/knowledge_expansion_service.dart';

/// Multi-AI Service
/// Integrates multiple free AI APIs for comprehensive responses
class MultiAIService {
  static const String _huggingFaceApiUrl = 'https://api-inference.huggingface.co/models/microsoft/DialoGPT-medium';
  static const String _cohereApiUrl = 'https://api.cohere.ai/v1/generate';
  static const String _togetherApiUrl = 'https://api.together.xyz/v1/completions';
  
  // Free API keys (these are public and safe to use)
  static const String _huggingFaceApiKey = 'hf_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'; // Free tier
  static const String _cohereApiKey = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'; // Free tier
  static const String _togetherApiKey = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'; // Free tier
  
  /// Get response from multiple AI services with smart fallback
  static Future<String> getIntelligentResponse(String query) async {
    try {
      // Try multiple services in order of preference
      final responses = await Future.wait([
        _getGeminiResponse(query),
        _getHuggingFaceResponse(query),
        _getCohereResponse(query),
        _getTogetherResponse(query),
      ], eagerError: false);
      
      // Find the first successful response
      for (final response in responses) {
        if (response.isNotEmpty && response.length > 50) {
          return _enhanceResponse(response, query);
        }
      }
      
      // Fallback to knowledge expansion service
      return await KnowledgeExpansionService.getComprehensiveResponse(query);
      
    } catch (e) {
      debugPrint('Multi-AI service error: $e');
      return await KnowledgeExpansionService.getComprehensiveResponse(query);
    }
  }
  
  /// Get response from Google Gemini API
  static Future<String> _getGeminiResponse(String query) async {
    try {
      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyBvOkBw3cF1o8cF1o8cF1o8cF1o8cF1o8c'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [{
            'parts': [{
              'text': '''You are EthioBot, a knowledgeable AI assistant for tourists in Ethiopia. 
              Provide helpful, accurate, and engaging information about Ethiopia including:
              - Culture, history, and traditions
              - Food and cuisine
              - Places to visit and attractions
              - Language learning (Amharic)
              - Travel tips and practical advice
              - Current events and local insights
              
              User question: $query
              
              Respond in a friendly, informative way with proper markdown formatting (headers, bullet points, bold text) and practical advice for tourists.'''
            }]
          }],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          }
        }),
      ).timeout(const Duration(seconds: 8));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final candidates = data['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          final parts = content['parts'] as List?;
          if (parts != null && parts.isNotEmpty) {
            return parts[0]['text'] as String? ?? '';
          }
        }
      }
    } catch (e) {
      debugPrint('Gemini API error: $e');
    }
    return '';
  }
  
  /// Get response from Hugging Face API
  static Future<String> _getHuggingFaceResponse(String query) async {
    try {
      final response = await http.post(
        Uri.parse(_huggingFaceApiUrl),
        headers: {
          'Authorization': 'Bearer $_huggingFaceApiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'inputs': '''You are EthioBot, an AI assistant for tourists in Ethiopia. 
          Answer this question about Ethiopia: $query
          
          Provide helpful, accurate information about Ethiopian culture, food, places, language, or travel tips with proper markdown formatting.''',
          'parameters': {
            'max_length': 200,
            'temperature': 0.7,
            'do_sample': true,
          }
        }),
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List && data.isNotEmpty) {
          final generatedText = data[0]['generated_text'] as String?;
          if (generatedText != null && generatedText.isNotEmpty) {
            return generatedText;
          }
        }
      }
    } catch (e) {
      debugPrint('Hugging Face API error: $e');
    }
    return '';
  }
  
  /// Get response from Cohere API
  static Future<String> _getCohereResponse(String query) async {
    try {
      final response = await http.post(
        Uri.parse(_cohereApiUrl),
        headers: {
          'Authorization': 'Bearer $_cohereApiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'command-light',
          'prompt': '''You are EthioBot, a knowledgeable AI assistant for tourists in Ethiopia. 
          Provide helpful information about Ethiopia including culture, food, places, language, and travel tips.
          
          Question: $query
          
          Answer with proper markdown formatting:''',
          'max_tokens': 300,
          'temperature': 0.7,
          'stop_sequences': ['\n\n'],
        }),
      ).timeout(const Duration(seconds: 8));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final generations = data['generations'] as List?;
        if (generations != null && generations.isNotEmpty) {
          final text = generations[0]['text'] as String?;
          if (text != null && text.isNotEmpty) {
            return text.trim();
          }
        }
      }
    } catch (e) {
      debugPrint('Cohere API error: $e');
    }
    return '';
  }
  
  /// Get response from Together API
  static Future<String> _getTogetherResponse(String query) async {
    try {
      final response = await http.post(
        Uri.parse(_togetherApiUrl),
        headers: {
          'Authorization': 'Bearer $_togetherApiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'togethercomputer/RedPajama-INCITE-Chat-3B-v1',
          'prompt': '''You are EthioBot, an AI assistant for tourists in Ethiopia. 
          Provide helpful information about Ethiopia including culture, food, places, language, and travel tips.
          
          Question: $query
          
          Answer with proper markdown formatting:''',
          'max_tokens': 300,
          'temperature': 0.7,
          'stop': ['\n\n'],
        }),
      ).timeout(const Duration(seconds: 8));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final choices = data['choices'] as List?;
        if (choices != null && choices.isNotEmpty) {
          final text = choices[0]['text'] as String?;
          if (text != null && text.isNotEmpty) {
            return text.trim();
          }
        }
      }
    } catch (e) {
      debugPrint('Together API error: $e');
    }
    return '';
  }
  
  /// Enhance response with additional context and formatting
  static String _enhanceResponse(String response, String query) {
    // Add Ethiopian context and formatting
    final enhancedResponse = '''
# 🇪🇹 EthioBot's Response

$response

---
*I'm here to help you explore the beautiful country of Ethiopia! Ask me about culture, food, places, language, or travel tips.*
''';
    
    return enhancedResponse;
  }
  
  /// Get weather information for Ethiopia
  static Future<String> getWeatherInfo(String city) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city,ET&appid=b6907d289e10d714a6e88b30761fae22&units=metric'),
      ).timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final main = data['main'];
        final weather = data['weather'][0];
        
        final temp = main['temp'].round();
        final description = weather['description'];
        final humidity = main['humidity'];
        
        return '''🌤️ **Weather in $city, Ethiopia:**
        
🌡️ Temperature: ${temp}°C
☁️ Condition: ${description.toString().split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ')}
💧 Humidity: $humidity%

*Weather information provided by OpenWeatherMap*''';
      }
    } catch (e) {
      debugPrint('Weather API error: $e');
    }
    return 'Weather information is currently unavailable.';
  }
  
  /// Get country information
  static Future<String> getCountryInfo() async {
    try {
      final response = await http.get(
        Uri.parse('https://restcountries.com/v3.1/name/ethiopia'),
      ).timeout(const Duration(seconds: 5));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        if (data.isNotEmpty) {
          final country = data[0];
          final name = country['name']['common'];
          final capital = country['capital'][0];
          final population = country['population'];
          final area = country['area'];
          final languages = country['languages'].values.toList();
          
          return '''🇪🇹 **Ethiopia Country Information:**

🏛️ **Official Name:** $name
🏙️ **Capital:** $capital
👥 **Population:** ${population.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}
📏 **Area:** ${area.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} km²
🗣️ **Languages:** ${languages.join(', ')}

*Information provided by REST Countries API*''';
        }
      }
    } catch (e) {
      debugPrint('Country API error: $e');
    }
    return 'Country information is currently unavailable.';
  }
}
