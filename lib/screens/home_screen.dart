import 'package:flutter/material.dart';
import '../utils/app_config.dart';
import '../widgets/custom_drawer.dart';
import 'message_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(AppConfig.recipientName),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConfig.backgroundColor,
              AppConfig.secondaryColor.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // عنوان الترحيب
                Text(
                  AppConfig.homeWelcomeTitle,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppConfig.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // رسالة الترحيب
                Text(
                  AppConfig.homeWelcomeMessage,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppConfig.secondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // التورتة المتحركة
                AnimatedBuilder(
                  animation: _heartController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_heartController.value * 0.2),
                      child: const Text(
                        '🎂',
                        style: TextStyle(fontSize: 100),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // بطاقة الصورة الرئيسية
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppConfig.primaryColor.withOpacity(0.3),
                            AppConfig.secondaryColor.withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/profile.jpg',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'الصورة غير موجودة',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'أضف الصورة في assets/images/profile.jpg',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // زر الرسالة
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MessageScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConfig.secondaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.mail, size: 28),
                        const SizedBox(width: 12),
                        Text(
                          AppConfig.homeMessageButton,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // بالونات متحركة
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('🎈', style: TextStyle(fontSize: 40)),
                    Text('🎉', style: TextStyle(fontSize: 40)),
                    Text('🎁', style: TextStyle(fontSize: 40)),
                    Text('🎊', style: TextStyle(fontSize: 40)),
                  ],
                ),
                const SizedBox(height: 40),

                // العلامة المائية
                Text(
                  AppConfig.homeWatermark,
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
    );
  }
}