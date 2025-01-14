import 'package:final_ibilling/core/utils/utils_service.dart';
import 'package:final_ibilling/feature/main_wrapper/main_wrap.dart';
import 'package:final_ibilling/feature/main_wrapper/pin_keyboard.dart';
import 'package:final_ibilling/feature/main_wrapper/seasonal_effect.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinput/pinput.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = LocalAuthentication();
  final _focusNode = FocusNode();
  final _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkBiometricAuth();
  }

  Future<void> _checkBiometricAuth() async {
    try {
      final isAvailable = await _auth.canCheckBiometrics;
      final isDeviceSupported = await _auth.isDeviceSupported();

      if (isAvailable && isDeviceSupported) {
        final isAuthenticated = await _auth.authenticate(
          localizedReason: 'Iltimos, shaxsingizni tasdiqlang',
          options: const AuthenticationOptions(stickyAuth: true, useErrorDialogs: true, biometricOnly: true),
        );
        if (isAuthenticated) _navigateToHome();
      } else {
        _showError('Biometrik autentifikatsiya qo‘llab-quvvatlanmaydi.');
      }
    } catch (e) {
      _showError('Xatolik yuz berdi: $e');
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainWrap()),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IgnorePointer(child: seasonalEffectWidget(Range(0.1, 7), context: context)),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Pinput(
                  controller: _pinController,
                  focusNode: _focusNode,
                  length: 4,
                  keyboardType: TextInputType.none,
                  onCompleted: (value) => (value == "1234")
                      ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainWrap()))
                      : Utils.fireSnackBar("InCorrect pin", context),
                ),
              ),
              75.verticalSpace,
              NumberKeyboardWidget(
                onKeyPressed: (value) {
                  if (_pinController.text.length < 4) _pinController.text += value;
                },
                onBackspacePressed: () {
                  if (_pinController.text.isNotEmpty) _pinController.text = _pinController.text.substring(0, _pinController.text.length - 1);
                },
                onFingerPrintPressed: () => _checkBiometricAuth(),
              ),
              50.verticalSpace,
            ],
          ),
          IgnorePointer(child: seasonalEffectWidget(Range(2, 12), context: context)),
        ],
      ),
    );
  }
}
