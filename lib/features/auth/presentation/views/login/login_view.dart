import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/error_ui/dialogs/show_dialog.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';
import 'package:peakmart/core/shared_widgets/text_fields.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/account_creation_or_login_prompt.dart';
import 'package:peakmart/features/auth/presentation/state_mang/login_cubit/sign_up_cubit.dart';
import 'package:peakmart/features/auth/presentation/views/reset_password/view.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view_model.dart';
import 'package:peakmart/features/auth/presentation/views/login/widgets/other_login_ways.dart';
import 'package:peakmart/features/main/main_view.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key, this.fromScreen});

  static const String routeName = '/login';
  final String? fromScreen;

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginCubit _loginCubit = instance<LoginCubit>();

  // final AppPreferences _appPreferences = instance<AppPreferences>();
  _bind() {
    _loginCubit.context = context;
    _emailController.addListener(
      () => _loginViewModel.setEmail(_emailController.text),
    );
    _passwordController.addListener(
      () => _loginViewModel.setPassword(_passwordController.text),
    );
    _loginViewModel.isUserLoginSuccessfullyStreamController.stream
        .listen((isLogin) {
      if (isLogin) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          // Navigator.of(context).pushNamed(
          //   OTPView.routeName,
          //   arguments: SendOtpInput(
          //     countryCode: _loginViewModel.loginRequest.countryCode,
          //     phone: _loginViewModel.loginRequest.phoneNum,
          //     fromScreen: widget.fromScreen,
          //     fromLogin: true,
          //   ),
          // );
        });
      }
    });
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
          if (state is SignUpFailureState) {
            ErrorViewer.showError(
                errorViewerOptions:  ErrVToastOptions(
                  backGroundColor: ColorManager.textFormErrorBorder,
                  textColor: ColorManager.white
                ),
                context: context,
                error: state.errors,
                callback: () {});
          }
          if(state is SignUpSuccessState){
            Navigator.pushReplacementNamed(context, MainView.routeName);
          }
        }, builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: AppSize.s130),
              Text(
                'Welcome Back!',
                style: getSemiBoldStyle(
                        fontSize: FontSize.s32, color: ColorManager.black)
                    .copyWith(fontFamily: FontConstants.fontMontserratFamily),
              ),
              const SizedBox(height: AppSize.s40),
              CustomTextFormWithStream(
                stream: _loginViewModel.outEmailValidation,
                prefixIcon: Icons.person,
                textEditingController: _emailController,
                hintText: AppStrings.email,
              ),
              const SizedBox(height: AppSize.s25),
              PasswordTextFieldWithStream(
                stream: _loginViewModel.outPasswordValidation,
                textEditingController: _passwordController,
              ),
              const SizedBox(height: AppSize.s14),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: CustomTextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPasswordView.routeName);
                  },
                  title: AppStrings.forgotPassword,
                ),
              ),
              const SizedBox(height: AppSize.s8),
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
              const SizedBox(height: AppSize.s35),
              const OtherLoginWays(),
              const SizedBox(height: AppSize.s20),
              const AccountCreationOrLoginPrompt(
                text: 'Create An Account',
                textButton: 'Sign Up',
              )
            ],
          );
        }),
      ),
    );
  }
}
