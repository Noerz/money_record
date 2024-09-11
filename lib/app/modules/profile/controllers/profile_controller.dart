import 'package:get/get.dart';
import 'package:catatan_keuangan/app/data/models/user_model.dart';
import 'package:catatan_keuangan/app/data/repositories/profile/profile_repository.dart';

class ProfileController extends GetxController {
  final _profileRepository = Get.find<ProfileRepository>();

  var profile = Rx<User?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isEditing = false.obs;

  // Editable fields
  var fullName = ''.obs;
  var adress = ''.obs;
  var noHp = ''.obs;
  var gender = 'Male'.obs; // Default value can be 'Male' or 'Female'

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading(true);
      final userProfile = await _profileRepository.getProfile();
      profile.value = userProfile;

      // Initialize the editable fields with the current profile data
      fullName.value = userProfile?.fullName ?? '';
      adress.value = userProfile?.adress ?? '';
      noHp.value = userProfile?.noHp ?? '';
      gender.value = userProfile?.gender ?? 'Male'; // Set default if null

      errorMessage('');
    } catch (e) {
      errorMessage('Failed to load profile: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading(true);

      // Update the profile in the repository
      await _profileRepository.updateProfile(
        fullName: fullName.value,
        adress: adress.value,
        noHp: noHp.value,
        gender: gender.value,
      );

      // Refresh the profile data
      await fetchProfile();

      isEditing(false);
    } catch (e) {
      errorMessage('Failed to update profile: $e');
    } finally {
      isLoading(false);
    }
  }
}
