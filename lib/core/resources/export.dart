// Dart & Core
export 'dart:async';
export 'dart:convert';
export 'dart:io';

export 'package:carousel_slider/carousel_slider.dart';
// App Controllers
export 'package:edu_bridge_app/controller.dart';
// Core Resources
export 'package:edu_bridge_app/core/resources/app_colors.dart';
export 'package:edu_bridge_app/core/resources/app_themes.dart';
export 'package:edu_bridge_app/core/localization/app_translations.dart';
export 'package:edu_bridge_app/core/resources/assets_path.dart';
export 'package:edu_bridge_app/core/resources/export.dart';
// Core Services
export 'package:edu_bridge_app/core/services/i_network_caller.dart';
export 'package:edu_bridge_app/core/services/network_caller.dart';
// Core Utils
export 'package:edu_bridge_app/core/utils/add_banner_form.dart';
export 'package:edu_bridge_app/core/utils/add_course_dialouge.dart';
export 'package:edu_bridge_app/core/utils/add_mentor_dialog.dart';
export 'package:edu_bridge_app/core/utils/centered_app_logo.dart';
export 'package:edu_bridge_app/core/utils/custom_button.dart';
export 'package:edu_bridge_app/core/utils/custom_header_text.dart';
export 'package:edu_bridge_app/core/utils/custom_scaffold.dart';
export 'package:edu_bridge_app/core/utils/custom_spacing.dart';
export 'package:edu_bridge_app/core/utils/custom_text.dart';
export 'package:edu_bridge_app/core/utils/custom_text_field.dart';
// Core UI Components
export 'package:edu_bridge_app/core/utils/language_switch.dart';
export 'package:edu_bridge_app/core/utils/reusable_content_view.dart';
export 'package:edu_bridge_app/core/utils/theme_switch.dart';
export 'package:edu_bridge_app/core/utils/validators.dart';
// Admin Content Post Widgets
export 'package:edu_bridge_app/feature/admin_content_post/widget/add_offer_slider.dart';
export 'package:edu_bridge_app/feature/admin_content_post/widget/add_popular_course.dart';
export 'package:edu_bridge_app/feature/admin_content_post/widget/add_top_mentor.dart';
// Auth Feature
export 'package:edu_bridge_app/feature/auth/repo/auth_resposity.dart';
export 'package:edu_bridge_app/feature/auth/view/forget_password_view.dart';
export 'package:edu_bridge_app/feature/auth/view/sign_in_view.dart';
export 'package:edu_bridge_app/feature/auth/view/splash_view.dart';
export 'package:edu_bridge_app/feature/auth/view_model/sign_in_controller.dart';
export 'package:edu_bridge_app/feature/auth/view_model/sign_up_controller.dart';
export 'package:edu_bridge_app/feature/auth/widgets/forgot_password_button.dart';
export 'package:edu_bridge_app/feature/auth/widgets/forgot_password_text_button.dart';
export 'package:edu_bridge_app/feature/auth/widgets/sign_in_button.dart';
export 'package:edu_bridge_app/feature/auth/widgets/sign_in_text_button.dart';
export 'package:edu_bridge_app/feature/auth/widgets/sign_up_button.dart';
export 'package:edu_bridge_app/feature/auth/widgets/sign_up_text_button.dart';
// Chapter_4 Feature
export 'package:edu_bridge_app/feature/capters_4/model/chapter_model.dart';
//Repository
export 'package:edu_bridge_app/feature/capters_4/repo/chapters_repository.dart';
export 'package:edu_bridge_app/feature/capters_4/repo/i_chapters_repository.dart';
export 'package:edu_bridge_app/feature/capters_4/view/chapters_view.dart';
export 'package:edu_bridge_app/feature/capters_4/view_model/chapters_controller.dart';
// Category_1 Feature
export 'package:edu_bridge_app/feature/category_1/model/category_model.dart';
export 'package:edu_bridge_app/feature/category_1/repo/category_repository.dart';
export 'package:edu_bridge_app/feature/category_1/repo/i_category_repository.dart';
export 'package:edu_bridge_app/feature/category_1/view/categories_view.dart';
export 'package:edu_bridge_app/feature/category_1/view_model/category_controller.dart';
// Class_2 Feature
export 'package:edu_bridge_app/feature/classes_2/model/class_model.dart';
export 'package:edu_bridge_app/feature/classes_2/repo/classes_repository.dart';
export 'package:edu_bridge_app/feature/classes_2/repo/i_classes_repository.dart';
export 'package:edu_bridge_app/feature/classes_2/view/class_view.dart';
export 'package:edu_bridge_app/feature/classes_2/view_model/class_controller.dart';
// Content_5 Feature
export 'package:edu_bridge_app/feature/content_5/model/content_model.dart';
export 'package:edu_bridge_app/feature/content_5/repo/content_repository.dart';
export 'package:edu_bridge_app/feature/content_5/repo/i_content_repository.dart';
export 'package:edu_bridge_app/feature/content_5/view/content_view.dart';
export 'package:edu_bridge_app/feature/content_5/view_model/content_controller.dart';
export 'package:edu_bridge_app/feature/content_5/widgets/add_content_view.dart';
export 'package:edu_bridge_app/feature/content_5/widgets/content_card.dart';
export 'package:edu_bridge_app/feature/content_5/widgets/youtube_view.dart';
// Course Feature
export 'package:edu_bridge_app/feature/course/model/popular_course_content_model.dart';
export 'package:edu_bridge_app/feature/course/model/popular_course_model.dart';
export 'package:edu_bridge_app/feature/course/repo/popular_course/i_popular_course_repository.dart';
export 'package:edu_bridge_app/feature/course/repo/popular_course/popular_courses_repository.dart';
export 'package:edu_bridge_app/feature/course/repo/popular_course_content/i_popular_course_content_repository.dart';
export 'package:edu_bridge_app/feature/course/repo/popular_course_content/popular_course_content_repository.dart';
export 'package:edu_bridge_app/feature/course/view/popular_course_content_view.dart';
export 'package:edu_bridge_app/feature/course/view/popular_courses_view.dart';
export 'package:edu_bridge_app/feature/course/view_model/popular_course_content_controller.dart';
export 'package:edu_bridge_app/feature/course/view_model/popular_course_controller.dart';
export 'package:edu_bridge_app/feature/home/view/banner/model/banner_model.dart';
export 'package:edu_bridge_app/feature/home/view/banner/repo/banner_repository.dart';
export 'package:edu_bridge_app/feature/home/view/banner/repo/i_banner_repository.dart';
// Home Feature
export 'package:edu_bridge_app/feature/home/view/banner/view_model/banner_controller.dart';
export 'package:edu_bridge_app/feature/home/view/home_view.dart';
export 'package:edu_bridge_app/feature/home/view/main_bottom_nav_bar.dart';
export 'package:edu_bridge_app/feature/home/view_model/main_bottom_navbar_controller.dart';
export 'package:edu_bridge_app/feature/home/widgets/all_categories.dart';
export 'package:edu_bridge_app/feature/home/widgets/category_section.dart';
export 'package:edu_bridge_app/feature/home/widgets/custom_scaffold_home.dart';
export 'package:edu_bridge_app/feature/home/widgets/home_banner.dart';
export 'package:edu_bridge_app/feature/home/widgets/popular_courses.dart';
// Mentor Feature
export 'package:edu_bridge_app/feature/mentor/model/mentor_model.dart';
export 'package:edu_bridge_app/feature/mentor/repo/mentor_repository.dart';
export 'package:edu_bridge_app/feature/mentor/view/top_mentor_details_view.dart';
export 'package:edu_bridge_app/feature/mentor/view/top_mentors_view.dart';
export 'package:edu_bridge_app/feature/mentor/view_model/mentor_controller.dart';
export 'package:edu_bridge_app/feature/on_boarding/view/intro/view/intro_view_1.dart';
export 'package:edu_bridge_app/feature/on_boarding/view/intro/view/intro_view_2.dart';
export 'package:edu_bridge_app/feature/on_boarding/view/intro/view/intro_view_3.dart';
// OnBoarding Feature
export 'package:edu_bridge_app/feature/on_boarding/view/on_boarding.dart';
export 'package:edu_bridge_app/feature/on_boarding/view_model/on_boarding_controller.dart';
// Setting Feature
export 'package:edu_bridge_app/feature/setting/view/settings_view.dart';
// Subject_3 Feature
export 'package:edu_bridge_app/feature/subject_3/model/subject_model.dart';
export 'package:edu_bridge_app/feature/subject_3/repo/i_subjects_repository.dart';
export 'package:edu_bridge_app/feature/subject_3/repo/subjects_repository.dart';
export 'package:edu_bridge_app/feature/subject_3/view/subjects_view.dart';
export 'package:edu_bridge_app/feature/subject_3/view_model/subject_controller.dart';
// Theming and Localization
export 'package:edu_bridge_app/feature/theming_and_loclization/view_model/localization_controller.dart';
export 'package:edu_bridge_app/feature/theming_and_loclization/view_model/theme_controller.dart';
// User Feature
export 'package:edu_bridge_app/feature/user/model/user_model.dart';
export 'package:edu_bridge_app/feature/user/model/user_profile_model.dart';
export 'package:edu_bridge_app/feature/user/repo/user_profile_repository.dart';
export 'package:edu_bridge_app/feature/user/view/fetch_user_profile_view.dart';
export 'package:edu_bridge_app/feature/user/view/user_profile_view.dart';
export 'package:edu_bridge_app/feature/user/view_model/user_profile_controller.dart';
export 'package:flutter/gestures.dart';
// Flutter & External Packages
export 'package:flutter/material.dart';
export 'package:flutter_dotenv/flutter_dotenv.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:get/get.dart' hide Response, HeaderValue;
export 'package:google_fonts/google_fonts.dart';
export 'package:image_picker/image_picker.dart';
export 'package:logger/logger.dart';
export 'package:pin_code_fields/pin_code_fields.dart';
export 'package:sizer/sizer.dart' hide ScreenType;
export 'package:smooth_page_indicator/smooth_page_indicator.dart';
export 'package:supabase_flutter/supabase_flutter.dart' hide MultipartFile;
export 'package:webview_flutter/webview_flutter.dart';
export 'package:youtube_player_flutter/youtube_player_flutter.dart';
