// ignore_for_file: prefer_const_constructors, unnecessary_new, sort_child_properties_last, use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/login_provider.dart';
import '/services/services.dart';
import '/ui/input_decorations.dart';
import '/widgets/widgets.dart';
import '/Colors/app_colors.dart';
import '/memes/memes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // Función para obtener un mensaje aleatorio de la lista
  String getRandomMessage() {
    final Random random = Random();
    return LoginMessages
        .messages[random.nextInt(LoginMessages.messages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getRandomMessage(),
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: AppColors.buttonGreenColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Image.asset(
              'assets/imgs/prodevil.gif',
              width: 400,
              height: 400,
            ),
            const SizedBox(height: 16),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'HUNT ENTRY',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.mhwblack,
                        ),
                  ),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: _LoginForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'register'),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                  AppColors.mhwhite.withOpacity(0.1),
                ),
                shape: MaterialStateProperty.all(StadiumBorder()),
              ),
              child: const Text(
                'REGISTER A NEW HUNTER',
                style:
                    TextStyle(fontSize: 25, color: AppColors.firePrimaryColor),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'test1@email.com',
              labelText: 'Email Address',
              prefixIcon: Icons.alternate_email_rounded,
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = new RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'A Invalid Email Format';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Test1@',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'The password must be 6 characters long';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: AppColors.icePrimaryColor,
            elevation: 0,
            color: AppColors.buttonGreenColor,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'WAIT...' : 'LOGIN',
                style: TextStyle(color: AppColors.mhwhite),
              ),
            ),
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    if (!loginForm.isValidForm()) return;

                    loginForm.isLoading = true;

                    final String? errorMessage = await authService.login(
                      loginForm.email,
                      loginForm.password,
                    );

                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(context, 'main');
                    } else {
                      NotificationsService.showSnackbar(errorMessage);
                      loginForm.isLoading = false;
                    }
                  },
          ),
        ],
      ),
    );
  }
}
