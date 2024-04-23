import "dart:io";

import "package:flutter/material.dart";
import "package:practice_flutter/core/constants/app_colors.dart";
import "package:practice_flutter/core/constants/constants.dart";
import "package:practice_flutter/core/utils/utils.dart";
import "package:practice_flutter/features/auth/presentation/widget/gender_picker.dart";
import "package:practice_flutter/widgets/pick_image_widget.dart";
import "package:practice_flutter/widgets/round_text_field.dart";

final _formKey = GlobalKey<FormState>();

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  File? image;
  late String gender = 'male';

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
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
                          textInputAction: TextInputAction.next
                        )
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child: RoundTextField(
                        controller: _lastNameController,
                        hintText: "Last Name",
                        textInputAction:  TextInputAction.next
                      )
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                GenderPicker(
                  gender: gender,
                  onChanged: (value) => {
                    if (gender == 'male') {
                      gender = 'female'
                    } else {
                      gender = 'male'
                    }
                  }
                ),


                RoundTextField(
                  controller: _emailController,
                  hintText: "Email",
                  textInputAction: TextInputAction.next,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
