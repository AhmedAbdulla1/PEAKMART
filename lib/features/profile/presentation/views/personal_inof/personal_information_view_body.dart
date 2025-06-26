import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/forget_password_view.dart';
import 'package:peakmart/features/profile/presentation/state_m/profile/cubit.dart';
import 'package:peakmart/features/profile/presentation/views/personal_inof/passwrod_dialog.dart';
import 'package:peakmart/features/profile/presentation/views/personal_inof/personal_info_form.dart';
import 'package:peakmart/features/profile/presentation/views/personal_inof/profile_avatar.dart';

class PersonalInformationViewBody extends StatefulWidget {
  const PersonalInformationViewBody({super.key});

  @override
  State<PersonalInformationViewBody> createState() =>
      _PersonalInformationViewBodyState();
}

class _PersonalInformationViewBodyState
    extends State<PersonalInformationViewBody> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController govController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isSeller = instance<AppPreferences>().getIsSeller();

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileCubit>().state;
    if (state is ProfileLoaded) {
      _setUserData(state);
    }
  }

  void _setUserData(ProfileLoaded state) {
    nameController.text = state.userInfo.userName;
    emailController.text = state.userInfo.email;
    phoneController.text = state.userInfo.phone;
    countryController.text = state.userInfo.sellerInfo["COUNTRY"] ?? '';
    cityController.text = state.userInfo.sellerInfo["CITY"] ?? '';
    govController.text = state.userInfo.sellerInfo["GOV"] ?? '';
    addressController.text = state.userInfo.sellerInfo["ADDRESS"] ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    countryController.dispose();
    cityController.dispose();
    govController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state as ProfileLoaded;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileAvatar(
                    tempImagePath: state.tempProfileImagePath,
                    imageUrl: state.userInfo.photo,
                    onEditTap: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        context
                            .read<ProfileCubit>()
                            .updateProfileImage(pickedFile.path);
                      }
                    },
                  ),
                  20.vGap,
                  PersonalInfoForm(
                    nameController: nameController,
                    emailController: emailController,
                    phoneController: phoneController,
                    countryController: countryController,
                    cityController: cityController,
                    govController: govController,
                    addressController: addressController,
                    isSeller: isSeller,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p30,
              vertical: AppPadding.p20,
            ),
            child: Column(
              children: [
                CustomElevatedButtonWithoutStream(
                  height: AppSize.s45,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ForgotPasswordView.routeName,
                    );
                  },
                  text: "Change Password",
                ),
                15.verticalSpace,
                CustomElevatedButtonWithoutStream(
                  height: AppSize.s45,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    showPasswordDialog(context).then((value) {
                      if (value != null) {
                        context.read<ProfileCubit>().saveChanges(value);
                      }
                    });
                  },
                  text: "Save",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
