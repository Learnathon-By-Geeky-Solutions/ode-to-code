import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/utils/user_profile_utils.dart';

class UserSavedItemView extends StatefulWidget {
  const UserSavedItemView({super.key});

  @override
  State<UserSavedItemView> createState() => _UserSavedItemViewState();
}

class _UserSavedItemViewState extends State<UserSavedItemView> {
  final UserProfileController profileController =
      Get.find<UserProfileController>();
  String? userId;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      await UserProfileUtils.fetchProfileData(profileController);
      if (profileController.userProfile != null && mounted) {
        setState(() {
          userId = profileController.userProfile?.id;
        });
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtil.showError('Error', 'Failed to load profile data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return userId == null // Show a loading indicator until userId is fetched
        ? const Center(child: CircularProgressIndicator())
        : GetBuilder<UserSavedItemController>(
            init: UserSavedItemController(
              repository:
                  UserSavedItemRepository(networkCaller: NetworkCaller()),
            ),
            builder: (controller) {
              return ReusableContentView(
                title: "Saved Items",
                id: userId!,
                fetchContents: controller.fetchSavedItems,
                getContents: () => controller.savedItems,
                isLoading: () => controller.inProgress,
                addContent: controller.addSavedItem,
                isSavedItemsView: true,
              );
            },
          );
  }

  @override
  void dispose() {
    super.dispose();
    // Optional: Clean up any controllers or subscriptions to prevent memory leaks
  }
}
