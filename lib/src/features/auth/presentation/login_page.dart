import 'package:flutter/material.dart';
import 'package:signal/src/extensions/extensions.dart';
import 'package:signal/src/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:signal/src/features/auth/presentation/widgets/divider.dart';
import 'package:signal/src/features/auth/presentation/widgets/extra_actions.dart';
import 'package:signal/src/features/auth/presentation/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Log in',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const LoginForm(),
              const FormDivider(),
              ExtraActions(
                onTap: context.development,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
