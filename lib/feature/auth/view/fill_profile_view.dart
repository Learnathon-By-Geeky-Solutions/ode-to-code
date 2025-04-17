import 'package:edu_bridge_app/core/resources/export.dart';

class FillProfileView extends StatefulWidget {
  const FillProfileView({super.key});

  @override
  State<FillProfileView> createState() => _FillProfileViewState();
}

class _FillProfileViewState extends State<FillProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
          backgroundColor: AppColors.bg,
          title: CustomText(
            text: "fill_your_profile".tr,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.bg),
                  child: const Icon(
                    Icons.person,
                    size: 95,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              const CustomTextFormField(labelText: "Full Name"),
              SizedBox(height: 2.h),
              const CustomTextFormField(labelText: "Nick Name"),
              SizedBox(height: 2.h),
              const CustomTextFormField(labelText: "Date of Birth"),
              SizedBox(height: 2.h),
              const CustomTextFormField(labelText: "Email"),
              SizedBox(height: 2.h),
              const CustomTextFormField(labelText: "phone"),
              SizedBox(height: 2.h),
              const CustomTextFormField(labelText: "Gender"),
              SizedBox(height: 2.h),
              CustomButton(
                text: "Sign In",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                onPressed: () {},
                backgroundColor: AppColors.themeColor,
                textColor: Colors.white,
                icon: Icons.arrow_forward,
                buttonType: ButtonType.elevated,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
