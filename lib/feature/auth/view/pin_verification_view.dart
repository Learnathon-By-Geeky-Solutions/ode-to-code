import 'package:edu_bridge_app/core/resources/export.dart';

class PinVerificationView extends StatefulWidget {
  const PinVerificationView({super.key});

  @override
  State<PinVerificationView> createState() => _PinVerificationViewState();
}

class _PinVerificationViewState extends State<PinVerificationView> {
  final TextEditingController _pinTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CustomText(
                text: 'add_pin_number_security'.tr,
              ),
            ),
            PinCodeTextField(
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 60,
                fieldWidth: 75,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                inactiveColor: Colors.grey.shade300,
                selectedColor: AppColors.themeColor,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              controller: _pinTEController,
              appContext: context,
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: AppColors.themeColor,
                  foregroundColor: Colors.white),
              child: Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: CustomText(
                        text: "Continue",
                      ),
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.themeColor,
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
