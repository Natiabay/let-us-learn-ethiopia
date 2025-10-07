/// Admin API Service for backend communication
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdminApiService {
  static const String baseUrl = 'http://localhost:8000';
  
  final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  AdminApiService() : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token to requests
        final token = await _storage.read(key: 'admin_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        print('API Error: ${error.response?.statusCode} - ${error.message}');
        return handler.next(error);
      },
    ));
  }
  
  // Authentication
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('/admin/auth/login', data: {
        'email': email,
        'password': password,
      });
      
      // Save token
      await _storage.write(
        key: 'admin_token',
        value: response.data['access_token']
      );
      
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await _dio.post('/admin/auth/change-password', data: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      });
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await _dio.get('/admin/auth/me');
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // Lessons
  Future<List<dynamic>> getLessons({
    int skip = 0,
    int limit = 50,
    String? status,
    String? languagePair,
    String? level,
  }) async {
    try {
      final response = await _dio.get('/admin/lessons', queryParameters: {
        'skip': skip,
        'limit': limit,
        if (status != null) 'status': status,
        if (languagePair != null) 'language_pair': languagePair,
        if (level != null) 'level': level,
      });
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<Map<String, dynamic>> createLesson(Map<String, dynamic> lessonData) async {
    try {
      final response = await _dio.post('/admin/lessons', data: lessonData);
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<void> publishLesson(int lessonId) async {
    try {
      await _dio.post('/admin/lessons/$lessonId/publish');
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<void> unpublishLesson(int lessonId) async {
    try {
      await _dio.post('/admin/lessons/$lessonId/unpublish');
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  Future<void> deleteLesson(int lessonId) async {
    try {
      await _dio.delete('/admin/lessons/$lessonId');
    } catch (e) {
      throw _handleError(e);
    }
  }
  
  // Error handling
  String _handleError(dynamic error) {
    if (error is DioError) {
      if (error.response != null) {
        final detail = error.response!.data['detail'];
        return detail is String ? detail : detail.toString();
      }
      return error.message ?? 'Network error occurred';
    }
    return error.toString();
  }
  
  Future<void> logout() async {
    await _storage.delete(key: 'admin_token');
  }
}
