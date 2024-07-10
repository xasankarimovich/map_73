import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../utils/colors/app_colors.dart';
import '../../view_models/maps_view_model.dart';
import '../widgets/adress.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddressesScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MapsViewModel>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: Lottie.asset('assets/lottie/location.json'),
        ),
      ),
    );
  }
}
