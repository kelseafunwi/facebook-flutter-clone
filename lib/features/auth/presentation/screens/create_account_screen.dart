import "dart:io";

import "package:flutter/material.dart";
import "package:practice_flutter/core/constants/app_colors.dart";
import "package:practice_flutter/core/constants/constants.dart";
import "package:practice_flutter/core/utils/utils.dart";
import "package:practice_flutter/features/auth/presentation/widget/gender_picker.dart";
import "package:practice_flutter/widgets/pick_image_widget.dart";
import "package:practice_flutter/widgets/round_text_field.dart";
import 'package:practice_flutter/utils/utils.dart';

final _formKey = GlobalKey<FormState>();

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  File? image;
  late String gender = "male";

  // create some textEditingControllers which are used to hold access to the different textfields that were created.
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // initialize the textfields in the init state
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.realWhiteColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: Constants.defaultPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    // call the pickImage function as soon as the user clicks on the icon
                    // return the image and reset the state of the object with setState.
                    image = await pickImage();
                    setState(() {});
                  },
                  child: PickImageWidget(image: image)
                ),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Expanded(
                        child: RoundTextField(
                          controller: _firstNameController,
                          hintText: "First Name",
                          textInputAction: TextInputAction.next,
                          validator: validateName,
                        )
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child: RoundTextField(
                        controller: _lastNameController,
                        hintText: "Last Name",
                        textInputAction:  TextInputAction.next,
                        validator: validateName,
                      )
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                GenderPicker(
                  gender: gender,
                  onChanged: (value) {
                    gender = value ?? 'male';
                    // checks if there is something in the value and there will only be something in the value
                    // if the user toggle the value of the radio
                    setState(() => {

                    });
                  }
                ),


                RoundTextField(
                  controller: _emailController,
                  hintText: "Email",
                  textInputAction: TextInputAction.next,
                  validator: validateEmail,
                ),

                const SizedBox(
                  height: 20,
                ),

                RoundTextField(
                  controller: _emailController,
                  hintText: "Password",
                  isPassword: true,
                  textInputAction: TextInputAction.next,
                  validator: validatePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
