// lib/screens/message_screen.dart
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/app_config.dart';
import '../widgets/custom_drawer.dart';

class MessageScreen extends StatefulWidget {
  final String userName;

  const MessageScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _heartController;
  late Animation<double> _fadeAnimation;
  AppConfig? _config;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _heartController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fadeController.forward();
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
          _config?.messageTitle ?? 'الرسالة 💌',
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
        currentIndex: 1,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: Stack(
          children: [
            // قلوب طائرة في الخلفية
            ..._buildFloatingHearts(),

            // المحتوى الرئيسي
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      // أيقونة الرسالة
                      ScaleTransition(
                        scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: _fadeController,
                            curve: Curves.elasticOut,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.secondary,
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.mail,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // بطاقة الرسالة
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // عنوان الرسالة
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '${_config?.messageHeader ?? 'إلى'} ${widget.userName}',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 24,
                                ),
                              ],
                            ),

                            const SizedBox(height: 25),

                            // خط فاصل
                            Container(
                              height: 2,
                              width: 100,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.secondary,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),

                            const SizedBox(height: 25),

                            // نص الرسالة
                            Text(
                              _config?.messageContent ?? 'عيد ميلاد سعيد! نتمنى لك يومًا مليئًا بالفرح والسعادة. كل سنة وأنت طيب وبخير. أتمنى أن تتحقق كل أحلامك وأمنياتك. استمتع بيومك الخاص! 🎂🎉',
                              style: const TextStyle(
                                fontSize: 18,
                                height: 1.8,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 30),

                            // الزخارف
                            Wrap(
                              spacing: 15,
                              runSpacing: 15,
                              alignment: WrapAlignment.center,
                              children: [
                                _buildEmoji('🎂'),
                                _buildEmoji('🎉'),
                                _buildEmoji('🎁'),
                                _buildEmoji('🎈'),
                                _buildEmoji('✨'),
                                _buildEmoji('🎊'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // بطاقة شموع
                      _buildCandlesCard(),

                      const SizedBox(height: 30),

                      // watermark
                      Container(
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
                              _config?.messageWatermark ?? 'Made with Birthday Gift App',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmoji(String emoji) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 28),
      ),
    );
  }

  Widget _buildCandlesCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withOpacity(0.2),
            AppColors.secondary.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            _config?.messageCandlesTitle ?? '🕯️ اطفئ الشموع 🕯️',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return ScaleTransition(
                scale: Tween<double>(begin: 0.9, end: 1.1).animate(
                  CurvedAnimation(
                    parent: _heartController,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      '🔥',
                      style: TextStyle(fontSize: 28),
                    ),
                    Container(
                      width: 8,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Text(
            _config?.messageCandlesSubtitle ?? 'تمنى أمنية واطفئ الشموع! ✨',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFloatingHearts() {
    return List.generate(8, (index) {
      return Positioned(
        left: (index * 50.0) % MediaQuery.of(context).size.width,
        bottom: -30,
        child: AnimatedBuilder(
          animation: _heartController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                -MediaQuery.of(context).size.height *
                    (_heartController.value + (index * 0.15)) %
                    1.5,
              ),
              child: Opacity(
                opacity: 0.2,
                child: Icon(
                  Icons.favorite,
                  size: 25,
                  color: Colors.red.withOpacity(0.6),
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
    _fadeController.dispose();
    _heartController.dispose();
    super.dispose();
  }
}