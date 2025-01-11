import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:final_ibilling/core/utils/utils_service.dart';
import 'package:final_ibilling/feature/main_wrapper/main_wrap.dart';
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
    _checkBiometricAuth(); // Initial biometric check
  }

  Future<void> _checkBiometricAuth() async {
    try {
      final isAvailable = await _auth.canCheckBiometrics;
      final isDeviceSupported = await _auth.isDeviceSupported();

      if (isAvailable && isDeviceSupported) {
        final isAuthenticated = await _auth.authenticate(
          localizedReason: 'Iltimos, shaxsingizni tasdiqlang',
          options: const AuthenticationOptions(
            stickyAuth: true,
            useErrorDialogs: true,
            biometricOnly: true,
          ),
        );

        if (isAuthenticated) {
          _navigateToHome();
        } else {
          _showError('Autentifikatsiya muvaffaqiyatsiz tugadi.');
        }
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
                  onCompleted: (value){
                    if(value == "1234"){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MainWrap()));
                    }else{
                      Utils.fireSnackBar("InCorrect pin", context);
                    }
                  },
                ),
              ),
              75.verticalSpace,

              // Custom Number Keyboard
              NumberKeyboardWidget(
                onKeyPressed: (value) {
                  if (_pinController.text.length < 4) {
                    _pinController.text += value; // Append the key
                  }
                },
                onBackspacePressed: () {
                  if (_pinController.text.isNotEmpty) {
                    _pinController.text = _pinController.text.substring(
                      0,
                      _pinController.text.length - 1,
                    );
                  }
                },
                onFingerPrintPressed: () {
                  _checkBiometricAuth(); // Trigger biometric auth
                },
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

class NumberKeyboardWidget extends StatelessWidget {
  final void Function(String) onKeyPressed;
  final void Function() onBackspacePressed;
  final void Function() onFingerPrintPressed;

  const NumberKeyboardWidget({
    super.key,
    required this.onKeyPressed,
    required this.onFingerPrintPressed,
    required this.onBackspacePressed,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'F', '0', 'X'];

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
      itemCount: keys.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 2,
      ),
      itemBuilder: (context, index) {
        final key = keys[index];
        return MaterialButton(
          minWidth: 20,
          height: 20,
          onPressed: key == 'X' ? onBackspacePressed : key == 'F' ? onFingerPrintPressed : () => onKeyPressed(key),
          color: AppColors.greenDark.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          child: key == 'X' ? const Icon(Icons.backspace_outlined) : key == 'F' ? const Icon(Icons.fingerprint) : Text(key),
        );
      },
    );
  }
}

