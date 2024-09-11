import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:catatan_keuangan/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    controller.fetchProfile();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          Obx(() => controller.isEditing.value
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    controller.updateProfile();
                  },
                )
              : Container())
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final user = controller.profile.value;
        if (user == null) {
          return Center(child: Text('Profile not found'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: 'Full Name',
                initialValue: user.fullName ?? '',
                enabled: controller.isEditing.value,
                onChanged: (value) => controller.fullName.value = value,
              ),
              SizedBox(height: 16),
              _buildTextField(
                label: 'Address',
                initialValue: user.adress ?? '',
                enabled: controller.isEditing.value,
                onChanged: (value) => controller.adress.value = value,
              ),
              SizedBox(height: 16),
              _buildTextField(
                label: 'Phone',
                initialValue: user.noHp ?? '',
                enabled: controller.isEditing.value,
                onChanged: (value) => controller.noHp.value = value,
              ),
              SizedBox(height: 16),
              _buildGenderDropdown(
                initialValue: user.gender ?? 'Male', // Default value
                enabled: controller.isEditing.value,
                onChanged: (value) => controller.gender.value = value!,
              ),
              SizedBox(height: 16),
              // Display profile image if exists
              if (user.image != null)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'URL_TO_YOUR_IMAGE_STORAGE/${user.image}',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(height: 16),
              // Display toggle button for edit mode
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    controller.isEditing.value = !controller.isEditing.value;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isEditing.value ? Colors.red : Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 5,
                  ),
                  child: Text(controller.isEditing.value ? 'Cancel' : 'Edit Profile'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required bool enabled,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.5),
        ),
      ),
      enabled: enabled,
      onChanged: onChanged,
    );
  }

  Widget _buildGenderDropdown({
    required String initialValue,
    required bool enabled,
    required Function(String?) onChanged,
  }) {
    const List<String> genderOptions = ['male', 'female'];

    return DropdownButtonFormField<String>(
      value: enabled ? (genderOptions.contains(initialValue) ? initialValue : null) : null,
      decoration: InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(),
      ),
      onChanged: enabled ? onChanged : null,
      items: genderOptions.map((gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender.capitalizeFirst!),
        );
      }).toList(),
    );
  }
}
