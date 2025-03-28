import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/core/shared_widgets/text_fields.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/account_creation_or_login_prompt.dart';
import 'package:peakmart/features/auth/presentation/state_mang/login_cubit/cubit.dart';
import 'package:peakmart/features/auth/presentation/state_mang/social_sign_in_cubit/social_sign_in_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view_model.dart';
import 'package:peakmart/features/auth/presentation/views/login/widgets/other_login_ways.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/view.dart';
import 'package:peakmart/features/main/main_view.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key, this.fromScreen});

  static const String routeName = 'LoginView';
  final String? fromScreen;

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginCubit _loginCubit = instance<LoginCubit>();
  _bind() {
    _loginCubit.context = context;
    _emailController.addListener(
      () => _loginViewModel.setEmail(_emailController.text),
    );
    _passwordController.addListener(
      () => _loginViewModel.setPassword(_passwordController.text),
    );
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _loginCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: BlocProvider<LoginCubit>(
            create: (context) => _loginCubit, child: _getContent()),
      ),
    );
  }

  Widget _getContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
        child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
          if (state is LoginFailureState) {
            print('state.errors ${state.errors}');
            ErrorViewer.showError(
                errorViewerOptions: const ErrVToastOptions(
                    backGroundColor: ColorManager.textFormErrorBorder,
                    textColor: ColorManager.white),
                context: context,
                error: state.errors,
                callback: () {});
          }
          if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, MainView.routeName);
          }
        }, builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              130.vGap,
              Text(
                AppStrings.welcomeBack,
                style: getSemiBoldStyle(fontSize: FontSize.s32)
                    .copyWith(fontFamily: FontConstants.fontMontserratFamily),
              ),
              40.vGap,
              CustomTextFormWithStream(
                stream: _loginViewModel.outEmailValidation,
                prefixIcon: Icons.person,
                textEditingController: _emailController,
                hintText: AppStrings.email,
              ),
              25.vGap,
              PasswordTextFieldWithStream(
                stream: _loginViewModel.outPasswordValidation,
                textEditingController: _passwordController,
              ),
              8.vGap,
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: CustomTextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPasswordView.routeName);
                  },
                  title: AppStrings.forgotPassword,
                  textStyle: getRegularStyle(
                      fontSize: FontSize.s14,
                      color: context.isDarkMode
                          ? ColorManager.white
                          : ColorManager.black),
                ),
              ),
              8.vGap,
              CustomElevatedButton(
                stream: _loginViewModel.outAreInputsValid,
                text: AppStrings.login,
                onPressed: () {
                  _loginCubit.login(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                },
              ),
              35.vGap,
              BlocProvider(
                create: (context) => SignInWithSocialCubit(),
                child: const OtherLoginWays(),
              ),
              20.vGap,
              AccountCreationOrLoginPrompt(
                text: AppStrings.createAccount,
                textButton: AppStrings.signUp,
              ),
              20.vGap,
            ],
          );
        }),
      ),
    );
  }
}
