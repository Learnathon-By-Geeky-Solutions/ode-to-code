import 'package:edu_bridge_app/core/resources/export.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'appTitle': 'EduBridge',
          'welcome': 'Welcome!',
          //Auth
          'lets_sign_in': "Let's Sign In",
          'login_to_continue': 'Login to Your Account to Continue Learning',
          'password': 'Password',
          'signUp': 'Sign Up',
          'signIn': 'Sign In',
          'signOut': 'Sign Out',
          'profile': 'Profile',

          //reset password
          "back_to_sign_in": "Back to Sign In",
          "password_reset_email_sent":
              "Password reset email sent! Please check your inbox.",
          "update_your_password": "Update Your Password",
          "enter_new_password": "Enter and confirm your new password.",
          "update_password": "Update Password",
          //forgot password
          "forgot_password_title": "Forgot your password?",
          "forgot_password_subtitle":
              "Don’t worry! Enter your email to reset it and get back on track.",
          "reset_password": "Reset Password",
          //Home
          'home': 'Home',
          'settings': 'Settings',
          'dark_mode': 'Dark Mode',
          'language': 'Language',
          // Course UI
          'popular_courses': 'Popular Courses',
          'add_course_details': 'Add Course Details',
          'add_course_type': 'Add Course Type',
          'add_course_title': 'Add Course Title',
          'add_price': 'Add Price',
          'course_name_hint': 'Course Name',
          'course_price_hint': 'Course Price',
          'course_type_hint': 'Course Type',
          'add_image': 'Add Image',
          'add': 'Add',
          'error_fill_fields': 'Please fill all fields and add an image.',
          'price': 'Price',
          // Banner UI
          'add_banner': 'Add Banner',
          'enter_banner_name': 'Enter banner name',
          'no_image_selected': 'No image selected',
          // Mentor UI
          'top_mentor': 'Top Mentor',
          'add_mentor_name': 'Add Mentor Name',
          'add_mentor_info': 'Add Mentor Information',
          'designation_hint': 'Designation',
          'what_he_do_hint': 'What he do',
          'description_hint': 'Description',

          // English additions
          'label_name': 'Name',
          'label_designation': 'Designation',
          'label_what_he_do': 'What He Do',
          'label_description': 'Description',
          'user_email': 'User Email',
          'warning': 'Warning',
          // User Profile Form
          'full_name': 'Full Name',
          'what_you_do': 'What You Do',
          'account_type': 'Account Type',
          'date_of_birth': 'Date of Birth',
          'gender': 'Gender',
          'email': 'Email',
          // Other
          'add_class': 'Add Class',
          'enter_class_name': 'Enter Class Name',
          'fill_your_profile': 'Fill Your Profile',
          'your_profile': 'Your Profile',
          'popular_course': 'Popular Course',
          'see_all': 'SEE ALL',
          'forget_password': 'Forget Password',
          'categories': 'Categories',
          'hi_there': 'Hi there!',
          'search_prompt': 'What would you like to learn today? \nSearch below',
          'no_content_available': 'No content available',
          'add_pin_number_security':
              'Add a Pin Number to Make Your Account\n more Secure',
          'add_new_chapter': 'Add New Chapter',
          'enter_chapter_name': 'Enter Chapter Name',
          'add_subject_name': 'Add Subject Name',
          'no_notes_yet': 'No notes yet. Add one above!',
          'no_banners_available': 'No banners available',
          'skip': 'Skip',
          'get_started': 'Get Started',
          'next': 'Next',
          'select_language': 'Select Language',
          'toggle_theme': 'Toggle Theme',
          'education_for_everyone': 'Education For Everyone',
          'empowering_minds':
              'Empowering Minds, Building a Better Bangladesh\nLearn for Free!',
          'learn_and_share': 'Learn and Share',
          'learn_teach_inspire':
              'Learn, Teach, and Inspire Together, We Create Change!',
          'transform_the_future': 'Transform the Future',
          'knowledge_our_progress':
              'Your Knowledge, Our Progress Shaping a New Bangladesh!',
          'no_user_profile_found': 'No user profile found',
          'about_user': 'About User',
          'notification': 'Notification',
          'help_center': 'Help Center',
          'invite_friends': 'Invite Friends',
          'sign_out': 'Sign Out',
          'saved_items': 'Saved Items',
          'post_content': 'Post Content',
          'not_a_penny': 'Not a penny',
          'add_content': 'Add Content',
          'subjects': 'Subjects',
          'enter_subject_name': 'Enter Subject Name',

          // Other translations...
          'saved_item': 'Saved Item',
        },
        'bn': {
          //Auth
          'lets_sign_in': 'চলুন সাইন ইন করি',
          'login_to_continue': 'শেখা চালিয়ে যেতে আপনার অ্যাকাউন্টে লগইন করুন',
          'password': 'পাসওয়ার্ড',
          'signUp': 'সাইন আপ',
          'sign_out': 'সাইন আউট',
          'saved_items': 'সংরক্ষিত আইটেমসমূহ',
          'subjects': 'বিষয়সমূহ',

          //reset password
          "back_to_sign_in": "সাইন ইন পেজে ফিরে যান",
          "password_reset_email_sent":
              "পাসওয়ার্ড রিসেট ইমেইল পাঠানো হয়েছে! দয়া করে আপনার ইনবক্স চেক করুন।",
          "update_your_password": "আপনার পাসওয়ার্ড আপডেট করুন",
          "enter_new_password": "নতুন পাসওয়ার্ড দিন এবং নিশ্চিত করুন।",
          "update_password": "পাসওয়ার্ড আপডেট করুন",
          //forgot password
          "forgot_password_title": "পাসওয়ার্ড ভুলে গেছেন?",
          "forgot_password_subtitle":
              "চিন্তা করবেন না! পুনরায় সেট করতে আপনার ইমেইল দিন।",
          "reset_password": "পাসওয়ার্ড রিসেট করুন",
          // User Profile Form
          'full_name': 'পূর্ণ নাম',
          'what_you_do': 'আপনি কী করেন',
          'account_type': 'অ্যাকাউন্টের ধরন',
          'date_of_birth': 'জন্ম তারিখ',
          'gender': 'লিঙ্গ',
          'email': 'ইমেইল',

          'add_pin_number_security':
              'আপনার অ্যাকাউন্টকে আরও নিরাপদ করতে একটি পিন নম্বর যোগ করুন',
          'appTitle': 'এডু ব্রিজ',
          'welcome': 'স্বাগতম!',
          'signIn': 'সাইন ইন',
          'signOut': 'সাইন আউট',
          'profile': 'প্রোফাইল',
          'saved_item': 'সংরক্ষিত আইটেম',
          'home': 'হোম',
          'settings': 'সেটিংস',
          'dark_mode': 'ডার্ক মোড',
          'language': 'ভাষা',
          // Course UI
          'popular_courses': 'জনপ্রিয় কোর্স',
          'add_course_details': 'কোর্সের বিস্তারিত যোগ করুন',
          'add_course_type': 'কোর্সের ধরন যোগ করুন',
          'add_course_title': 'কোর্সের শিরোনাম যোগ করুন',
          'add_price': 'মূল্য যোগ করুন',
          'course_name_hint': 'কোর্সের নাম',
          'course_price_hint': 'কোর্সের মূল্য',
          'course_type_hint': 'কোর্সের ধরন',
          'add': 'যোগ করুন',
          'error_fill_fields': 'সব ঘর পূরণ করুন এবং একটি ছবি যোগ করুন।',
          'price': 'মূল্য',
          'add_image': 'ছবি যোগ করুন',
          // Banner UI
          'add_banner': 'ব্যানার যোগ করুন',
          'enter_banner_name': 'ব্যানারের নাম লিখুন',
          'no_image_selected': 'কোনো ছবি নির্বাচন করা হয়নি',
          'insert_banner_instruction': '৩৬০x১৮০ ব্যানার দিন',
          // Mentor UI
          'top_mentor': 'শ্রেষ্ঠ মেন্টর',
          'add_mentor_name': 'মেন্টরের নাম যোগ করুন',
          'add_mentor_info': 'মেন্টরের তথ্য যোগ করুন',
          'designation_hint': 'পদবী',
          'what_he_do_hint': 'তিনি কি করেন',
          'description_hint': 'বর্ণনা',
          'label_name': 'নাম',
          'label_designation': 'পদবী',
          'label_what_he_do': 'তিনি যা করেন',
          'label_description': 'বর্ণনা',
          // Bangla additions
          'user_email': 'ইউজার ইমেইল',
          'warning': 'সতর্কতা',
          // Other

          'add_class': 'ক্লাস যোগ করুন',
          'enter_class_name': 'ক্লাসের নাম লিখুন',
          'fill_your_profile': 'আপনার প্রোফাইল পূরণ করুন',
          'popular_course': 'জনপ্রিয় কোর্স',
          'see_all': 'সব দেখুন',
          'forget_password': 'পাসওয়ার্ড ভুলে গেছেন',
          'categories': 'বিভাগসমূহ',
          'hi_there': 'হ্যালো!',
          'search_prompt': 'আজ আপনি কী শিখতে চান?\nনীচে অনুসন্ধান করুন',
          'your_profile': 'তোমার প্রোফাইল',
          'no_content_available': 'কোনো কনটেন্ট উপলব্ধ নেই',
          'add_new_chapter': 'নতুন অধ্যায় যোগ করুন',
          'enter_chapter_name': 'অধ্যায়ের নাম লিখুন',
          'add_subject_name': 'বিষয়ের নাম যোগ করুন',
          'no_notes_yet': 'এখনও কোনো নোট নেই। উপরের দিকে একটি যোগ করুন!',
          'no_banners_available': 'কোনো ব্যানার উপলব্ধ নেই',
          'skip': 'এড়িয়ে যান',
          'get_started': 'শুরু করুন',
          'next': 'পরবর্তী',
          'select_language': 'ভাষা নির্বাচন করুন',
          'toggle_theme': 'থিম পরিবর্তন করুন',
          'education_for_everyone': 'সবাই জন্য শিক্ষা',
          'empowering_minds':
              'মনের শক্তি, একটি উন্নত বাংলাদেশের নির্মাণ\nফ্রি শিখুন!',
          'learn_and_share': 'শিখুন এবং শেয়ার করুন',
          'learn_teach_inspire':
              'শিখুন, শেখান, এবং একসাথে অনুপ্রাণিত করুন, আমরা পরিবর্তন সৃষ্টি করি!',
          'transform_the_future': 'ভবিষ্যত রূপান্তর করুন',
          'knowledge_our_progress':
              'আপনার জ্ঞান, আমাদের অগ্রগতি, একটি নতুন বাংলাদেশের জন্য আকার!',
          'no_user_profile_found': 'কোনো ইউজার প্রোফাইল পাওয়া যায়নি',
          'about_user': 'ব্যবহারকারী সম্পর্কে',
          'notification': 'নোটিফিকেশন',
          'help_center': 'সাহায্য কেন্দ্র',
          'invite_friends': 'বন্ধুদের আমন্ত্রণ জানান',
          'post_content': 'কনটেন্ট পোস্ট করুন',
          'not_a_penny': 'এক পয়সাও নয়',
          'add_content': 'কনটেন্ট যোগ করুন',

          'enter_subject_name': 'বিষয়ের নাম লিখুন',
        },
      };
}
