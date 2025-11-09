import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import '../utils/app_config.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late ConfettiController _confettiController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _balloonController;
  late Animation<Offset> _balloonAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    _balloonController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _balloonAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.3),
    ).animate(CurvedAnimation(
      parent: _balloonController,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
    _confettiController.play();
    _playMusic();

    // الانتقال التلقائي بعد المدة المحددة
    Future.delayed(Duration(seconds: AppConfig.splashDuration), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  void _playMusic() async {
    try {
      // محاولة تشغيل الموسيقى من assets
      // ملاحظة: يجب إضافة ملف happy_birthday.mp3 في assets/music/
      await _audioPlayer.play(AssetSource('music/happy_birthday.mp3'));
    } catch (e) {
      // في حالة عدم وجود الملف، لا نفعل شيء
      debugPrint('Music file not found: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    _balloonController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppConfig.primaryColor,
              AppConfig.secondaryColor,
              AppConfig.accentColor.withOpacity(0.5),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Confetti
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.05,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.1,
                shouldLoop: false,
                colors: const [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.yellow,
                  Colors.pink,
                  Colors.purple,
                ],
              ),
            ),

            // المحتوى الرئيسي
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // الكعكة المتحركة
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: const Text(
                      '🎂',
                      style: TextStyle(fontSize: 120),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // العنوان
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      AppConfig.splashTitle,
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black26,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // اسم صاحب عيد الميلاد
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      AppConfig.splashSubtitle,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black26,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // بالونات متحركة
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _balloonAnimation,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('🎈', style: TextStyle(fontSize: 40)),
                          SizedBox(width: 10),
                          Text('🎉', style: TextStyle(fontSize: 40)),
                          SizedBox(width: 10),
                          Text('🎈', style: TextStyle(fontSize: 40)),
                          SizedBox(width: 10),
                          Text('🎊', style: TextStyle(fontSize: 40)),
                          SizedBox(width: 10),
                          Text('🎈', style: TextStyle(fontSize: 40)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
