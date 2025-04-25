// Dart & Core
export 'dart:async';
export 'dart:convert';
export 'dart:io';

export 'package:cached_network_image/cached_network_image.dart';
export 'package:carousel_slider/carousel_slider.dart';
// App Controllers
export 'package:edu_bridge_app/controller.dart';
export 'package:edu_bridge_app/core/localization/app_translations.dart';
// Core Resources
export 'package:edu_bridge_app/core/resources/app_colors.dart';
export 'package:edu_bridge_app/core/resources/app_themes.dart';
export 'package:edu_bridge_app/core/resources/assets_path.dart';
export 'package:edu_bridge_app/core/resources/export.dart';
// Auth Feature
export 'package:edu_bridge_app/core/services/auth_service/auth_service.dart';
export 'package:edu_bridge_app/core/services/network_service/api_response.dart';
export 'package:edu_bridge_app/core/services/network_service/i_network_caller.dart';
export 'package:edu_bridge_app/core/services/network_service/network_caller.dart';
// Core Services
export 'package:edu_bridge_app/core/services/network_service/networks_utils.dart';
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
export 'package:edu_bridge_app/core/utils/snackbar_util.dart';
export 'package:edu_bridge_app/core/utils/theme_switch.dart';
export 'package:edu_bridge_app/core/utils/validators.dart';
// Admin Content Post Widgets
export 'package:edu_bridge_app/feature/admin_content_post/widget/add_offer_slider.dart';
export 'package:edu_bridge_app/feature/admin_content_post/widget/add_popular_course.dart';
export 'package:edu_bridge_app/feature/auth/forgot_password/view/forget_password_view.dart';
export 'package:edu_bridge_app/feature/auth/forgot_password/widgets/forgot_password_button.dart';
export 'package:edu_bridge_app/feature/auth/forgot_password/widgets/forgot_password_text_button.dart';
export 'package:edu_bridge_app/feature/auth/sign_in/view/sign_in_view.dart';
export 'package:edu_bridge_app/feature/auth/sign_in/view_model/sign_in_controller.dart';
export 'package:edu_bridge_app/feature/auth/sign_in/widgets/sign_in_text_button.dart';
export 'package:edu_bridge_app/feature/auth/splash_view/splash_view.dart';
// Category_1 Feature
export 'package:edu_bridge_app/feature/category/model/category_model.dart';
export 'package:edu_bridge_app/feature/category/repo/category_repository.dart';
export 'package:edu_bridge_app/feature/category/repo/i_category_repository.dart';
export 'package:edu_bridge_app/feature/category/view/categories_view.dart';
export 'package:edu_bridge_app/feature/category/view_model/category_controller.dart';
// Chapter_4 Feature
export 'package:edu_bridge_app/feature/chapters/model/chapter_model.dart';
//Repository
export 'package:edu_bridge_app/feature/chapters/repo/chapters_repository.dart';
export 'package:edu_bridge_app/feature/chapters/repo/i_chapters_repository.dart';
export 'package:edu_bridge_app/feature/chapters/view/chapters_view.dart';
export 'package:edu_bridge_app/feature/chapters/view_model/chapters_controller.dart';
// Class_2 Feature
export 'package:edu_bridge_app/feature/classes/model/class_model.dart';
export 'package:edu_bridge_app/feature/classes/repo/classes_repository.dart';
export 'package:edu_bridge_app/feature/classes/repo/i_classes_repository.dart';
export 'package:edu_bridge_app/feature/classes/view/class_view.dart';
export 'package:edu_bridge_app/feature/classes/view_model/class_controller.dart';
export 'package:edu_bridge_app/feature/classes/widget/add_class_dialog.dart';
export 'package:edu_bridge_app/feature/classes/widget/class_grid_item.dart';
// Content_5 Feature
export 'package:edu_bridge_app/feature/content/model/content_model.dart';
export 'package:edu_bridge_app/feature/content/repo/content_repository.dart';
export 'package:edu_bridge_app/feature/content/repo/i_content_repository.dart';
export 'package:edu_bridge_app/feature/content/view/content_view.dart';
export 'package:edu_bridge_app/feature/content/view/note_details_view.dart';
export 'package:edu_bridge_app/feature/content/view/youtube_view.dart';
export 'package:edu_bridge_app/feature/content/view_model/content_controller.dart';
export 'package:edu_bridge_app/feature/content/widgets/add_content_view.dart';
export 'package:edu_bridge_app/feature/content/widgets/content_card.dart';
// Course Feature
export 'package:edu_bridge_app/feature/courses/model/popular_course_content_model.dart';
export 'package:edu_bridge_app/feature/courses/model/popular_course_model.dart';
export 'package:edu_bridge_app/feature/courses/repo/popular_course/i_popular_course_repository.dart';
export 'package:edu_bridge_app/feature/courses/repo/popular_course/popular_courses_repository.dart';
export 'package:edu_bridge_app/feature/courses/repo/popular_course_content/i_popular_course_content_repository.dart';
export 'package:edu_bridge_app/feature/courses/repo/popular_course_content/popular_course_content_repository.dart';
export 'package:edu_bridge_app/feature/courses/view/popular_course_content_view.dart';
export 'package:edu_bridge_app/feature/courses/view/popular_courses_view.dart';
export 'package:edu_bridge_app/feature/courses/view_model/popular_course_content_controller.dart';
export 'package:edu_bridge_app/feature/courses/view_model/popular_course_controller.dart';
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
export 'package:edu_bridge_app/feature/subjects/model/subject_model.dart';
export 'package:edu_bridge_app/feature/subjects/repo/i_subjects_repository.dart';
export 'package:edu_bridge_app/feature/subjects/repo/subjects_repository.dart';
export 'package:edu_bridge_app/feature/subjects/view/subjects_view.dart';
export 'package:edu_bridge_app/feature/subjects/view_model/subject_controller.dart';
// Theming and Localization
export 'package:edu_bridge_app/feature/theming_and_localization/view_model/localization_controller.dart';
export 'package:edu_bridge_app/feature/theming_and_localization/view_model/theme_controller.dart';
// User Feature
export 'package:edu_bridge_app/feature/user/model/user_profile_model.dart';
export 'package:edu_bridge_app/feature/user/repo/user_profile_repository.dart';
//export 'package:edu_bridge_app/feature/profile/view/fetch_user_profile_view.dart';

export 'package:edu_bridge_app/feature/user/view/user_profile_view.dart';
export 'package:edu_bridge_app/feature/user/view_model/sign_up_controller.dart';
export 'package:edu_bridge_app/feature/user/view_model/user_profile_controller.dart';
export 'package:edu_bridge_app/feature/user_saved_item/model/user_saved_item_model.dart';
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
