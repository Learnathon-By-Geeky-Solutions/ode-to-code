import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/home/bottom%20nav%20bar/main_bottom_nav_bar.dart';
import 'package:edu_bridge_app/view/on_boarding/on_boarding.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moveToNextScreen();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;

    if (session?.user != null) {
      Get.offAll(() => MainBottomNavView());
    } else {
      Get.offAll(() => const OnBoarding());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Image.asset(
            AssetsPath.appLogo2,
            width: 200,
          ),
        ),
      ),
    );
  }
}
