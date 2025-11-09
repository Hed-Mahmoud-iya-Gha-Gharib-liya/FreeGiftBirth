import 'package:flutter/material.dart';
import '../utils/app_config.dart';
import 'splash_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  bool _showError = false;
  late AnimationController _balloonController;

  @override
  void initState() {
    super.initState();
    _balloonController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balloonController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final enteredName = _nameController.text.trim();
    if (enteredName.toLowerCase() ==
        AppConfig.recipientName.toLowerCase()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    } else {
      setState(() {
        _showError = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showError = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConfig.primaryColor,
              AppConfig.secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // بالونات متحركة
                  AnimatedBuilder(
                    animation: _balloonController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -10 * _balloonController.value),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildBalloon('🎈', Colors.red),
                            _buildBalloon('🎈', Colors.blue),
                            _buildBalloon('🎈', Colors.yellow),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),

                  // العنوان
                  Text(
                    AppConfig.loginTitle,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // العنوان الفرعي
                  Text(
                    AppConfig.loginSubtitle,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),

                  // بطاقة الإدخال
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          // أيقونة الهدية
                          const Icon(
                            Icons.card_giftcard,
                            size: 80,
                            color: Colors.pink,
                          ),
                          const SizedBox(height: 24),

                          // حقل الإدخال
                          TextField(
                            controller: _nameController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              hintText: AppConfig.loginNameHint,
                              prefixIcon: const Icon(Icons.person),
                            ),
                            onSubmitted: (_) => _handleLogin(),
                          ),
                          const SizedBox(height: 24),

                          // زر الدخول
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _handleLogin,
                              child: Text(
                                AppConfig.loginButtonText,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          // رسالة الخطأ
                          if (_showError) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.red),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.error_outline,
                                      color: Colors.red),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      AppConfig.loginErrorMessage,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // العلامة المائية
                  Text(
                    AppConfig.loginWatermark,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBalloon(String emoji, Color color) {
    return Text(
      emoji,
      style: const TextStyle(fontSize: 40),
    );
  }
}
