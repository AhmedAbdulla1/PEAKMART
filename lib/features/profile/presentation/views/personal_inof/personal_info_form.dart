import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/shared_widgets/custom_text_field.dart';
import 'package:peakmart/core/shared_widgets/select_country_widget.dart';
import 'package:peakmart/features/profile/presentation/state_m/profile/cubit.dart';

class PersonalInfoForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController govController;
  final TextEditingController addressController;
  final bool isSeller;

  const PersonalInfoForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.countryController,
    required this.cityController,
    required this.govController,
    required this.addressController,
    required this.isSeller,
  });

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.vGap,
        CustomTextField(
          prefixIcon: Icons.person_2_outlined,
          label: "Name",
          controller: widget.nameController,
          onChanged: context.read<ProfileCubit>().updateName,
        ),
        16.vGap,
        CustomTextField(
          prefixIcon: Icons.email_outlined,
          label: "Email",
          controller: widget.emailController,
          onChanged: context.read<ProfileCubit>().updateEmail,
        ),
        16.vGap,
        CustomTextField(
          prefixIcon: Icons.phone_android_outlined,
          label: "Phone Number",
          controller: widget.phoneController,
          onChanged: context.read<ProfileCubit>().updatePhoneNumber,
        ),
        if (widget.isSeller)
          Column(
            children: [
              16.vGap,
              SelectCountryWidget(
                controller: widget.countryController,
              ),
              16.vGap,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      prefixIcon: Icons.location_city_outlined,
                      label: "City",
                      controller: widget.cityController,
                      onChanged: context.read<ProfileCubit>().updateCity,
                    ),
                  ),
                  10.hGap,
                  Expanded(
                    child: CustomTextField(
                      prefixIcon: Icons.account_balance_outlined,
                      label: "Gov",
                      controller: widget.govController,
                      onChanged: context.read<ProfileCubit>().updateGov,
                    ),
                  ),
                ],
              ),
              16.vGap,
              CustomTextField(
                prefixIcon: Icons.edit_location_alt,
                isMultiLine: true,
                label: "Address",
                controller: widget.addressController,
                onChanged: context.read<ProfileCubit>().updateAddress,
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
    );
  }
}
