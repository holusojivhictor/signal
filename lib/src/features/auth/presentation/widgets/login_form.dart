import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signal/src/config/injection.dart';
import 'package:signal/src/features/auth/application/auth_bloc.dart';
import 'package:signal/src/features/auth/presentation/widgets/form_field/form_field_with_header.dart';
import 'package:signal/src/features/common/domain/constants.dart';
import 'package:signal/src/features/common/presentation/button/primary_button.dart';
import 'package:signal/src/features/common/presentation/colors.dart';
import 'package:signal/src/features/common/presentation/styles.dart';
import 'package:signal/src/routing/app_router.dart';
import 'package:signal/src/utils/toast_utils.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static const passwordLength = 8;
  bool submitted = false;
  bool obscure = true;

  String? emailError;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: getIt<AuthBloc>(),
      listener: listener,
      builder: (ctx, state) => Container(
        margin: Styles.edgeInsetAll16,
        padding: Styles.edgeInsetAll20,
        decoration: const BoxDecoration(
          borderRadius: Styles.formBorderRadius,
          color: AppColors.secondaryShade,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FormFieldWithHeader(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                header: 'Email Address',
                hintText: 'you@example.com',
                autoValidate: submitted,
                errorText: emailError,
                validator: (value) {
                  if (value!.isEmpty) {
                    return kEmailNullError;
                  } else if (!emailValidatorRegExp.hasMatch(value)) {
                    return kInvalidEmailError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              FormFieldWithHeader(
                controller: passwordController,
                textInputType: TextInputType.text,
                header: 'Password',
                hintText: 'Not less than 8 characters',
                obscure: obscure,
                autoValidate: submitted,
                errorText: passwordError,
                validator: (value) {
                  if (value!.isEmpty) {
                    return kPassNullError;
                  } else if (value.length < passwordLength) {
                    return kShortPassError;
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  onPressed: () => setState(() => obscure = !obscure),
                  icon: Icon(
                    obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Log in',
                onPressed: _login,
                textColor: Colors.black87,
                hasLoading: state.status == AuthStatus.loading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    setState(() => submitted = true);
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final event = AuthLogin(
        username: emailController.text,
        password: passwordController.text,
      );
      getIt<AuthBloc>().add(event);
    }
  }

  void listener(BuildContext context, AuthState state) {
    final fToast = ToastUtils.of(context);
    final status = state.status;
    if (status == AuthStatus.loaded && state.isLoggedIn) {
      ToastUtils.showSucceedToast(fToast, 'Login successful');
      context.go(AppRoute.home.path);
    } else if (status == AuthStatus.failure) {
      ToastUtils.showWarningToast(fToast, 'Login failed');
    }
  }
}
