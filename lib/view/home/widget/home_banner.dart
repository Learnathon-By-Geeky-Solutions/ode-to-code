import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:edu_bridge_app/user_app.dart';
import 'package:edu_bridge_app/view_model/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final BannerController _bannerController = Get.put(BannerController());
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _bannerController.fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      builder: (controller) {
        if (controller.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.banners.isEmpty) {
          return const Center(child: Text("No banners available"));
        }

        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              items: controller.banners.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.network(
                          banner.imageLink,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported,
                                size: 60);
                          },
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.banners.map((banner) {
                int index = controller.banners.indexOf(banner);
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        _current == index ? AppColors.themeColor : Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
