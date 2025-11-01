// lib/utils/app_config.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppConfig {
  static AppConfig? _instance;
  late Map<String, dynamic> _config;

  AppConfig._();

  static Future<AppConfig> getInstance() async {
    if (_instance == null) {
      _instance = AppConfig._();
      await _instance!._loadConfig();
    }
    return _instance!;
  }

  Future<void> _loadConfig() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/gift_data.json');
      _config = json.decode(jsonString);
    } catch (e) {
      // في حالة عدم وجود الملف، استخدم القيم الافتراضية
      _config = _getDefaultConfig();
    }
  }

  Map<String, dynamic> _getDefaultConfig() {
    return {
      "occasion": "birthday",
      "giftName": "غالية",
      "giftIconPath": "assets/appimage/appimage.jpg",
      "createdByPhone": "01147857132",
      "theme": {
        "name": "أزرق وبني",
        "primaryColor": 4288423858,
        "secondaryColor": 4286259203,
        "accentColor": 4294956800,
        "backgroundColor": 4294967285
      },
      "loginPage": {
        "recipientName": "غالية"
      },
      "homePage": {
        "imagePath": "assets/main/main.jpg"
      },
      "messagePage": {
        "message": "عيد ميلاد سعيد! نتمنى لك يومًا مليئًا بالفرح والسعادة. كل سنة وأنت طيب وبخير. أتمنى أن تتحقق كل أحلامك وأمنياتك. استمتع بيومك الخاص! 🎂🎉"
      },
      "createdAt": "2025-11-02T00:37:04.629"
    };
  }

  // الحصول على اسم الهدية
  String get giftName => _config['giftName'] ?? 'غالية';

  // الحصول على الاسم المسموح به
  String get allowedName => _config['loginPage']?['recipientName'] ?? 'غالية';

  // الحصول على مسار أيقونة التطبيق
  String get giftIconPath => _config['giftIconPath'] ?? 'assets/appimage/appimage.jpg';

  // الحصول على مسار الصورة الرئيسية
  String get mainImagePath => _config['homePage']?['imagePath'] ?? 'assets/main/main.jpg';

  // الحصول على الألوان من الثيم
  Color get primaryColor {
    try {
      return Color(_config['theme']?['primaryColor'] ?? 4288423858);
    } catch (e) {
      return const Color(0xFF4A90E2);
    }
  }

  Color get secondaryColor {
    try {
      return Color(_config['theme']?['secondaryColor'] ?? 4286259203);
    } catch (e) {
      return const Color(0xFF8B4513);
    }
  }

  Color get accentColor {
    try {
      return Color(_config['theme']?['accentColor'] ?? 4294956800);
    } catch (e) {
      return const Color(0xFFFFD700);
    }
  }

  Color get backgroundColor {
    try {
      return Color(_config['theme']?['backgroundColor'] ?? 4294967285);
    } catch (e) {
      return const Color(0xFFF5F5F5);
    }
  }

  // نصوص شاشة تسجيل الدخول
  String get loginTitle => 'هدية عيد ميلاد 🎉';
  String get loginSubtitle => 'ادخل لتستمتع بهديتك';
  String get loginNameHint => 'اكتب اسمك هنا';
  String get loginButtonText => 'دخول 🎁';
  String get loginErrorMessage => 'من فضلك اكتب اسمك';
  String get loginWrongNameMessage => 'عذراً، هذه الهدية ليست لك!';
  String get loginWatermark => 'Made with Birthday Gift App';

  // نصوص الشاشة الرئيسية
  String get homeTitle => '🎉 عيد ميلاد سعيد 🎉';
  String get homeSubtitle => 'نتمنى لك يوم رائع!';
  String get homePhotoText => 'صورة';
  String get homeButtonText => 'اقرأ الرسالة 💌';
  String get homeWatermark => 'Made with Birthday Gift App';

  // نصوص شاشة الرسالة
  String get messageTitle => 'الرسالة 💌';
  String get messageHeader => 'إلى';
  String get messageContent => _config['messagePage']?['message'] ?? 'عيد ميلاد سعيد! نتمنى لك يومًا مليئًا بالفرح والسعادة. كل سنة وأنت طيب وبخير. أتمنى أن تتحقق كل أحلامك وأمنياتك. استمتع بيومك الخاص! 🎂🎉';
  String get messageCandlesTitle => '🕯️ اطفئ الشموع 🕯️';
  String get messageCandlesSubtitle => 'تمنى أمنية واطفئ الشموع! ✨';
  String get messageWatermark => 'Made with Birthday Gift App';
}
