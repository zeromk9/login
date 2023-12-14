// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print, use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/Colors/app_colors.dart';
import '/providers/login_provider.dart';
import '/services/services.dart';
import '/ui/input_decorations.dart';
import '/widgets/widgets.dart';
import '/memes/memes.dart';

class RegistrarScreen extends StatelessWidget {
  const RegistrarScreen({super.key});

  // Función para obtener un mensaje aleatorio de la lista
  String getRandomMessage() {
    final Random random = Random();
    return RegisterMessages
        .rmessages[random.nextInt(RegisterMessages.rmessages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getRandomMessage(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: AppColors.firePrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Image.asset(
              'assets/imgs/newdevil.gif',
              width: 400,
              height: 400,
            ),
            SizedBox(height: 16),
            CardContainer(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'CREATE A NEW HUNTER',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.mhwblack,
                        ),
                  ),
                  SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: _LoginForm(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                  AppColors.mhwhite.withOpacity(0.2),
                ),
                shape: MaterialStateProperty.all(StadiumBorder()),
              ),
              child: Text(
                'ARE YOU ALREADY A HUNTER?',
                style:
                    TextStyle(fontSize: 25, color: AppColors.buttonGreenColor),
              ),
            ),
            SizedBox(height: 50),
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
                prefixIcon: Icons.alternate_email_rounded),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'A invalid email format, example of valid format: name123@email.com';
            },
          ),
          SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Test1@',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'The password must be 6 characters long';
            },
          ),
          SizedBox(height: 30),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: AppColors.iceSecondaryColor,
              elevation: 0,
              color: AppColors.firePrimaryColor,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'WAIT...' : 'REGISTER',
                    style: TextStyle(color: AppColors.mhwhite),
                  )),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;
                      final String? errorMessage = await authService.createUser(
                          loginForm.email, loginForm.password);
                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'monster');
                      } else {
                        //print(errorMessage);
                        loginForm.isLoading = false;
                      }
                    })
        ],
      ),
    );
  }
}
