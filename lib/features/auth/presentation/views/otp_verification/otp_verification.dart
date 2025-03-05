import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/auth/domain/entity/register_entity.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/auth/presentation/state_mang/otp_verfication_cubit/otp_verfication_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification_body.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({
    super.key,
    required this.verificationType,
    this.registerEntity,
  });

  final VerificationType verificationType;

  final RegisterEntity? registerEntity;
  static const String routeName = '/otp_verification';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: CustomAppBar(
          title: AppStrings.otp,
        ),
        body: BlocProvider<OtpVerfictionCubit>(
            create: (context) => verificationType == VerificationType.watsApp
                ? (OtpVerfictionCubit()..sendWatsAppOtp())
                : (OtpVerfictionCubit()),
            child: OtpVerificationBody(
              registerEntity: registerEntity,
            )),
      ),
    );
  }
}

enum VerificationType { email, watsApp }
