import 'package:edu_bridge_app/core/resources/export.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
      init: OnBoardingController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Stack(
            children: [
              PageView(
                controller: controller.controller,
                onPageChanged: controller.onPageChanged,
                children: const [
                  IntroView1(),
                  IntroView2(),
                  IntroView3(),
                ],
              ),
              Container(
                alignment: const Alignment(0, 0.7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: controller.skipToLastPage,
                      child: controller.onLastPage
                          ? const Text(" ")
                          : CustomText(text: 'skip'.tr),
                    ),
                    SmoothPageIndicator(
                      controller: controller.controller,
                      count: 3,
                      effect: const ScrollingDotsEffect(),
                    ),
                    controller.onLastPage
                        ? ElevatedButton(
                            onPressed: controller.goToSignIn,
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(200, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: AppColors.themeColor,
                              foregroundColor: Colors.white,
                            ),
                            child: CustomText(text: 'get_started'.tr),
                          )
                        : GestureDetector(
                            onTap: controller.nextPage,
                            child: CustomText(text: 'next'.tr),
                          ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
