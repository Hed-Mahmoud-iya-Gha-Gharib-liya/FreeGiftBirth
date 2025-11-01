// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/app_config.dart';
import '../widgets/custom_drawer.dart';
import 'message_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _confettiController;
  AppConfig? _config;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    _config = await AppConfig.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
            ),
          ),
        ),
        elevation: 0,
      ),
      drawer: CustomDrawer(
        userName: widget.userName,
        currentIndex: 0,
      ),
      body: Stack(
        children: [
          // الخلفية المتحركة
          ..._buildFloatingBalloons(),

          // المحتوى
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // بطاقة الترحيب
                  _buildWelcomeCard(),

                  const SizedBox(height: 25),

                  // صورة صاحب عيد الميلاد
                  _buildPhotoCard(),

                  const SizedBox(height: 25),

                  // زر الرسالة
                  _buildMessageButton(context),

                  const SizedBox(height: 30),

                  // watermark
                  _buildWatermark(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.8),
            AppColors.secondary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.celebration,
            size: 50,
            color: Colors.white,
          ),
          const SizedBox(height: 15),
          Text(
            _config?.homeTitle ?? '🎉 عيد ميلاد سعيد 🎉',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            widget.userName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  blurRadius: 5,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cake,
                  color: AppColors.accent,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _config?.homeSubtitle ?? 'نتمنى لك يوم رائع!',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              height: 300,
              width: double.infinity,
              color: AppColors.primary.withOpacity(0.1),
              child: Image.asset(
                _config?.mainImagePath ?? 'assets/main/main.jpg',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // في حالة عدم وجود الصورة، اعرض الأيقونة الافتراضية
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 100,
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${_config?.homePhotoText ?? 'صورة'} ${widget.userName}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDecorationIcon(Icons.favorite, Colors.red),
                const SizedBox(width: 15),
                _buildDecorationIcon(Icons.star, Colors.amber),
                const SizedBox(width: 15),
                _buildDecorationIcon(Icons.cake, AppColors.accent),
                const SizedBox(width: 15),
                _buildDecorationIcon(Icons.celebration, Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorationIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
        size: 25,
      ),
    );
  }

  Widget _buildMessageButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessageScreen(userName: widget.userName),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 8,
          shadowColor: AppColors.accent.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.card_giftcard, size: 28),
            const SizedBox(width: 12),
            Text(
              _config?.homeButtonText ?? 'اقرأ الرسالة 💌',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWatermark() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cake,
            color: AppColors.primary,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            _config?.homeWatermark ?? 'Made with Birthday Gift App',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFloatingBalloons() {
    return List.generate(5, (index) {
      return Positioned(
        left: (index * 80.0) % MediaQuery.of(context).size.width,
        bottom: -50,
        child: AnimatedBuilder(
          animation: _confettiController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                -MediaQuery.of(context).size.height *
                    (_confettiController.value + (index * 0.2)) %
                    1.5,
              ),
              child: Opacity(
                opacity: 0.3,
                child: Icon(
                  Icons.circle,
                  size: 30,
                  color: [
                    Colors.red,
                    Colors.blue,
                    Colors.yellow,
                    Colors.green,
                    Colors.purple
                  ][index],
                ),
              ),
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
}