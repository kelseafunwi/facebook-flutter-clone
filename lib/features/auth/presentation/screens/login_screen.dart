import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/core/constants/app_colors.dart';
import 'package:practice_flutter/core/screens/home_screen.dart';
import 'package:practice_flutter/features/auth/presentation/screens/create_account_screen.dart';
import 'package:practice_flutter/features/auth/providers/auth_provider.dart';
import 'package:practice_flutter/utils/utils.dart';
import 'package:practice_flutter/widgets/round_button.dart';
import 'package:practice_flutter/widgets/round_text_field.dart';

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
  String error = '';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.realWhiteColor,
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Center(
                    child: Image.asset(
                      'assets/images/figma.png',
                      width: 60,
                    ),
                  ),

                  ErrorWidget(error: error),

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
                            height: 30,
                          ),

                          !isLoading ?
                          RoundButton(
                              label: "Login",
                              onPressed: () async {
                                await loginToAccount();
                              }
                          ): const Center(
                            child: CircularProgressIndicator(),
                          ),


                          const SizedBox(
                            height: 20,
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

                  const SizedBox(
                    height: 20,
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
            ]
          ),
        ),
      ),
    );
  }

  Future<void> loginToAccount() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      isLoading = true;
      setState(() {  });
      await ref.read(authProvider).signIn(email: _emailController.text, password: _passwordController.text)
        .then((value){
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      })
      .catchError((error) {
        error = error.code.toString();
        setState(() {});
        if (kDebugMode) {
          print("error $error");
        }
      });
      setState(() {
        isLoading = false;
      });
    }
  }
}

class ErrorWidget extends StatelessWidget {

  final String error;

  const ErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
     switch (error) {
      case 'invalid-credential':
        return const Text("Invalid Credential", style: TextStyle(color: Colors.red, fontSize: 20));
      default: return Text(error, style: const TextStyle(color: Colors.red, fontSize: 20));
    }
  }
}

