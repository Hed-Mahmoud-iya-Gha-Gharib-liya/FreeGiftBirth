import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../utils/app_config.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _candleController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _candleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _candleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.messageTitle),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 15,
              gravity: 0.1,
              shouldLoop: true,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.pink,
              ],
            ),
          ),

          // المحتوى
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppConfig.backgroundColor,
                  AppConfig.primaryColor.withOpacity(0.1),
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // الكعكة مع الشموع
                    _buildCakeWithCandles(),
                    const SizedBox(height: 40),

                    // بطاقة الرسالة
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              AppConfig.accentColor.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            // أيقونة الرسالة
                            Icon(
                              Icons.mail_outline,
                              size: 60,
                              color: AppConfig.secondaryColor,
                            ),
                            const SizedBox(height: 20),

                            // نص الرسالة
                            Text(
                              AppConfig.messageContent,
                              style: const TextStyle(
                                fontSize: 18,
                                height: 1.6,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),

                            // قلوب
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('❤️', style: TextStyle(fontSize: 30)),
                                SizedBox(width: 10),
                                Text('💕', style: TextStyle(fontSize: 30)),
                                SizedBox(width: 10),
                                Text('❤️', style: TextStyle(fontSize: 30)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // بالونات
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('🎈', style: TextStyle(fontSize: 40)),
                        Text('🎉', style: TextStyle(fontSize: 40)),
                        Text('🎁', style: TextStyle(fontSize: 40)),
                        Text('🎊', style: TextStyle(fontSize: 40)),
                        Text('🎈', style: TextStyle(fontSize: 40)),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // العلامة المائية
                    Text(
                      AppConfig.messageWatermark,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCakeWithCandles() {
    return Column(
      children: [
        // الشموع
        AnimatedBuilder(
          animation: _candleController,
          builder: (context, child) {
            return Opacity(
              opacity: 0.7 + (_candleController.value * 0.3),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🕯️', style: TextStyle(fontSize: 30)),
                  SizedBox(width: 5),
                  Text('🕯️', style: TextStyle(fontSize: 30)),
                  SizedBox(width: 5),
                  Text('🕯️', style: TextStyle(fontSize: 30)),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        // الكعكة
        const Text(
          '🎂',
          style: TextStyle(fontSize: 100),
        ),
      ],
    );
  }
}
