import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/core/shared_widgets/custom_text_field.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/profile/presentation/state_m/profile/cubit.dart';
import 'package:peakmart/features/profile/presentation/views/personal_inof/passwrod_dialog.dart'; // Make sure this import is correct

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
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController govController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isSeller = false;
  AppPreferences appPreferences = instance<AppPreferences>();
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

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      context.read<ProfileCubit>().updateProfileImage(pickedFile.path);
    }
  }

  @override
  void initState() {
    super.initState();
    isSeller = appPreferences.getIsSeller();
    log("isSeller from AppPreferences in initState: $isSeller");
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
            countryController.text = state.userInfo.sellerInfo["COUNTRY"];
            cityController.text = state.userInfo.sellerInfo["CITY"];
            govController.text = state.userInfo.sellerInfo["GOV"];
            addressController.text = state.userInfo.sellerInfo["ADDRESS"];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: AppSize.s55.r + AppSize.s1_5.r,
                                child: CircleAvatar(
                                  radius: AppSize.s55.r,
                                  backgroundColor:
                                      Colors.purple.withOpacity(0.2),
                                  backgroundImage:
                                      state.tempProfileImagePath != null
                                          ? FileImage(
                                              File(state.tempProfileImagePath!))
                                          : NetworkImage(state.userInfo.photo)
                                              as ImageProvider,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: AppSize.s15.r + AppSize.s1_5.r,
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

                          20.vGap, // Name Field
                          CustomTextField(
                            icon: Icons.person_2_outlined,
                            label: "Name",
                            controller: nameController,
                            onChanged: (value) {
                              context.read<ProfileCubit>().updateName(value);
                            },
                          ),
                          16.vGap,
                          // Email Field
                          CustomTextField(
                            icon: Icons.email_outlined,
                            label: "Email",
                            controller: emailController,
                            onChanged: (value) {
                              context.read<ProfileCubit>().updateEmail(value);
                            },
                          ),
                          16.vGap,
                          // Phone Number Field
                          CustomTextField(
                            icon: Icons.phone_android_outlined,
                            label: "Phone Number",
                            controller: phoneController,
                            onChanged: (value) {
                              context
                                  .read<ProfileCubit>()
                                  .updatePhoneNumber(value);
                            },
                          ),
                          if (isSeller)
                            Column(
                              children: [
                                16.vGap,
                                CustomTextField(
                                  icon: Icons.location_history,
                                  label: "Country",
                                  controller: countryController,
                                  onChanged: (value) {
                                    // context.read<ProfileCubit>().updatePhoneNumber(value);
                                    // You should connect this to cubit.updateCountry(value);
                                  },
                                ),
                                16.vGap,
                                CustomTextField(
                                  icon: Icons.location_city_outlined,
                                  label: "City",
                                  controller: cityController,
                                  onChanged: (value) {
                                    // context.read<ProfileCubit>().updatePhoneNumber(value);
                                    // You should connect this to cubit.updateCity(value);
                                  },
                                ),
                                16.vGap,
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        icon: Icons.account_balance_outlined,
                                        label: "Gov",
                                        controller: govController,
                                        onChanged: (value) {
                                          // context.read<ProfileCubit>().updatePhoneNumber(value);
                                          // You should connect this to cubit.updateGov(value);
                                        },
                                      ),
                                    ),
                                    10.hGap,
                                    Expanded(
                                      child: CustomTextField(
                                        icon: Icons.edit_location_alt,
                                        label: "Address",
                                        controller: addressController,
                                        onChanged: (value) {
                                          // context.read<ProfileCubit>().updatePhoneNumber(value);
                                          // You should connect this to cubit.updateAddress(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          20.vGap,
                          Text(
                            "When you set up your personal information settings, you should take care to provide accurate information.",
                            style: getRegularStyle(
                              fontSize: FontSize.s14,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p30, vertical: AppPadding.p20),
                    child: Column(
                      children: [
                        CustomElevatedButtonWithoutStream(
                          height: AppSize.s45,
                          onPressed: () {
                            showPasswordDialog(context).then((value) {
                              print("value: $value");
                              if (value != null) {
                                context.read<ProfileCubit>().saveChanges(value);
                              }
                            });
                          },
                          text: "Change Password",
                        ),
                        15.vGap, // Spacing between buttons
                        CustomElevatedButtonWithoutStream(
                          height: AppSize.s45,
                          onPressed: () {
                            // showPasswordDialog(context).then((value) {
                            //   print("value: $value");
                            //   if (value != null) {
                            //     context.read<ProfileCubit>().saveChanges(value);
                            //   }
                            // },);
                          },
                          text: "Save",
                        ),
                      ],
                    ),
                  )
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
