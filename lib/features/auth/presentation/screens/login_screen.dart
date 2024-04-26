import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_flutter/features/auth/presentation/screens/create_account_screen.dart';
import 'package:practice_flutter/utils/utils.dart';
import 'package:practice_flutter/widgets/round_button.dart';
import 'package:practice_flutter/widgets/round_text_field.dart';

import '../../../../core/constants/constants.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: Constants.defaultPadding,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image.asset(
                'assets/images/figma.png',
                width: 60,
              ),
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [

                  RoundTextField(
                    controller: _emailController,
                    hintText: "Email",
                    textInputAction: TextInputAction.next,
                    validator: validateEmail,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  RoundTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    textInputAction: TextInputAction.next,
                    isPassword: true,
                    validator: validatePassword,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  RoundButton(
                      label: "Login",
                      onPressed: () {}
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  )
                ],

              )
            ),

            Column(
              children: [
                RoundButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateAccountScreen.routeName);
                  },
                  label: "Create new account",
                  color: Colors.transparent,
                ),

                const SizedBox(
                  height: 10,
                ),

                Image.asset(
                  'assets/images/vscode.png',
                  width: 60,
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
