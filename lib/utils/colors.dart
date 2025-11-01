// lib/utils/colors.dart
import 'package:flutter/material.dart';
import 'app_config.dart';

class AppColors {
  static AppConfig? _config;

  // تهيئة الألوان من الإعدادات
  static Future<void> initialize() async {
    _config = await AppConfig.getInstance();
  }

  // الألوان الديناميكية من الإعدادات
  static Color get primary => _config?.primaryColor ?? const Color(0xFF4A90E2);
  static Color get secondary => _config?.secondaryColor ?? const Color(0xFFFFB6C1);
  static Color get accent => _config?.accentColor ?? const Color(0xFFFFD700);
  static Color get background => _config?.backgroundColor ?? const Color(0xFFF5F5F5);
  
  // الألوان الثابتة
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
}