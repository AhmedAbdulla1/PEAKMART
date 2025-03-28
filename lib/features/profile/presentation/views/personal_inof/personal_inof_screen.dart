import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/profile/presentation/state_m/profile/cubit.dart';
import 'package:peakmart/features/profile/presentation/views/personal_inof/passwrod_dialog.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});
  static const String routeName = "/personal-info";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..fetchProfile(),
      child: const PersonalInformationView(),
    );
  }
}

class PersonalInformationView extends StatefulWidget {
  const PersonalInformationView({super.key});

  @override
  State<PersonalInformationView> createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends State<PersonalInformationView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      context.read<ProfileCubit>().updateProfileImage(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Personal Information"),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ErrorViewer.showError(
                context: context, error: state.error, callback: () {});
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: WaitingWidget());
          }

          if (state is ProfileLoaded) {
            nameController.text = state.userInfo.userName;
            emailController.text = state.userInfo.email;
            phoneController.text = state.userInfo.phone;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image
                  const Spacer(),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: AppSize.s55.r+AppSize.s1_5.r,
                        child: CircleAvatar(
                          radius: AppSize.s55.r,
                          backgroundColor: Colors.purple.withOpacity(0.2),
                          backgroundImage: state.tempProfileImagePath != null
                              ? FileImage(File(state.tempProfileImagePath!))
                              : NetworkImage(state.userInfo.photo)
                                  as ImageProvider,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: AppSize.s15.r+AppSize.s1_5.r,
                          backgroundColor: Colors.white,
                          child: GestureDetector(
                            onTap: () => _pickImage(context),
                            child: CircleAvatar(
                              radius: 15.r,
                              backgroundColor: const Color(0xffF2F4F7),
                              child: Icon(
                                Icons.mode_edit_outline_outlined,
                                size: 20.r,
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(height: 20.h),
                  // Name Field
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      labelText: "Name",
                    ),
                    onChanged: (value) {
                      context.read<ProfileCubit>().updateName(value);
                    },
                  ),
                  SizedBox(height: 16.h),
                  // Email Field
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      labelText: "Email",
                    ),
                    onChanged: (value) {
                      context.read<ProfileCubit>().updateEmail(value);
                    },
                  ),
                  SizedBox(height: 16.h),
                  // Phone Number Field
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      labelText: "Phone Number",
                    ),
                    onChanged: (value) {
                      context.read<ProfileCubit>().updatePhoneNumber(value);
                    },
                  ),
                  SizedBox(height: 20.h),
                  const Spacer(flex: 2,),
                  // Instruction Text
                  Text(
                    "When you set up your personal information settings, you should take care to provide accurate information.",
                    style: getRegularStyle(
                      fontSize: FontSize.s14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showPasswordDialog(context).then((value) {
                          print("value: $value");
                          if (value != null) {
                            context.read<ProfileCubit>().saveChanges(value);
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8D5524),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: getBoldStyle(
                          fontSize: FontSize.s16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            );
          }

          return const Center(child: WaitingWidget());
        },
      ),
    );
  }
}
