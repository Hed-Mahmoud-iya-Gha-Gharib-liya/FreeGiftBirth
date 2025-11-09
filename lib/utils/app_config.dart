import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppConfig {
  static Map<String, dynamic>? _config;

  static Future<void> initialize() async {
    final String response = await rootBundle.loadString('assets/config.json');
    _config = json.decode(response);
  }

  static String get appName => _config?['app_name'] ?? 'هدية غالية';
  static String get packageType => _config?['package_type'] ?? 'free';
  static String get recipientName => _config?['recipient_name'] ?? 'غالية';
  static String get occasion => _config?['occasion'] ?? 'birthday';

  // Theme colors
  static Color get primaryColor => Color(
      int.parse(_config?['theme']?['primary_color'] ?? '0xFF4A90E2'));
  static Color get secondaryColor => Color(
      int.parse(_config?['theme']?['secondary_color'] ?? '0xFFFF69B4'));
  static Color get accentColor =>
      Color(int.parse(_config?['theme']?['accent_color'] ?? '0xFFFFD700'));
  static Color get backgroundColor => Color(
      int.parse(_config?['theme']?['background_color'] ?? '0xFFF5F5F5'));

  // Login page
  static String get loginTitle => _config?['login']?['title'] ?? 'هدية غالية 🎁';
  static String get loginSubtitle =>
      _config?['login']?['subtitle'] ?? 'ادخل لتستمتع بهديتك';
  static String get loginNameHint =>
      _config?['login']?['name_hint'] ?? 'أدخل اسمك';
  static String get loginButtonText => _config?['login']?['button_text'] ?? 'دخول';
  static String get loginErrorMessage =>
      _config?['login']?['error_message'] ?? 'عذراً، هذه الهدية ليست لك!';
  static String get loginWatermark =>
      _config?['login']?['watermark'] ?? 'Made with Hediya Ghaliya';

  // Splash page
  static String get splashTitle => _config?['splash']?['title'] ?? 'Happy Birthday!';
  static String get splashSubtitle =>
      (_config?['splash']?['subtitle'] ?? '{{name}}')
          .replaceAll('{{name}}', recipientName);
  static int get splashDuration =>
      _config?['splash']?['duration_seconds'] ?? 3;

  // Home page
  static String get homeWelcomeTitle =>
      (_config?['home']?['welcome_title'] ?? '🎂 عيد ميلاد سعيد {{name}}! 🎂')
          .replaceAll('{{name}}', recipientName);
  static String get homeWelcomeMessage =>
      _config?['home']?['welcome_message'] ?? 'نتمنى لك يوماً مليئاً بالفرح والسعادة';
  static String get homeMessageButton =>
      _config?['home']?['message_button'] ?? 'اقرأ الرسالة 💌';
  static String get homeWatermark =>
      _config?['home']?['watermark'] ?? 'Made with Hediya Ghaliya';

  // Message page
  static String get messageTitle =>
      _config?['message']?['title'] ?? 'رسالة خاصة لك 💌';
  static String get messageContent =>
      _config?['message']?['content'] ??
      'عيد ميلاد سعيد! نتمنى لك يوماً مليئاً بالفرح والسعادة. 🎂🎉';
  static String get messageWatermark =>
      _config?['message']?['watermark'] ?? 'Made with Hediya Ghaliya';

  // Validity
  static int get validityDays => _config?['validity_days'] ?? 7;
  static String get createdAt => _config?['created_at'] ?? '2025-11-08';
}
