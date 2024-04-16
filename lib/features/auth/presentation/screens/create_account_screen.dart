import "dart:io";

import "package:flutter/material.dart";
import "package:practice_flutter/core/constants/app_colors.dart";
import "package:practice_flutter/core/constants/constants.dart";
import "package:practice_flutter/core/utils/utils.dart";
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

  // controllers
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

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
                            controller: firstNameController,
                            hintText: "First Name",
                            textInputAction: TextInputAction.next
                          )
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: RoundTextField(
                          controller: lastNameController,
                          hintText: "Last Name",
                          textInputAction:  TextInputAction.next
                        )
                      ),
                    ],
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
}
