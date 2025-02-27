import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/auth/data/model/request/register_request.dart';
import 'package:peakmart/features/auth/presentation/state_mang/register_cubit.dart/register_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/sign_up/widgets/sign_up_build_widgets.dart';



void passNotTheSame(BuildContext context) {
  ErrorViewer.showCustomError(context, AppStrings.passwordNotTheSame);
}

