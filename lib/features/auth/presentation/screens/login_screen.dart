import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/features/auth/presentation/screens/create_account_screen.dart';
import 'package:practice_flutter/features/auth/providers/auth_provider.dart';
import 'package:practice_flutter/utils/utils.dart';
import 'package:practice_flutter/widgets/round_button.dart';
import 'package:practice_flutter/widgets/round_text_field.dart';

import '../../../../core/constants/constants.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isLoading = false;

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

  Future<void> loginToAccount() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() { isLoading = true; });
      await ref.read(authProvider).signIn(email: _emailController.text, password: _passwordController.text)
          .then((value){
        // remove this current screen from the navigation
        Navigator.pop(context);
      })
          .catchError((onError) {
        showToastMessage(e: onError.toString());
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
                        onPressed: () {
                          loginToAccount();
                        }
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
      ),
    );
  }
}
