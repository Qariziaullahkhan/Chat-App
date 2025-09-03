import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/string.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/core/services/database_services.dart';
import 'package:chat_app/core/services/storage_services.dart';
import 'package:chat_app/ui/screens/auth/signup/signupview_model.dart';
import 'package:chat_app/ui/widgets/button_widget.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignupviewModel>(
      create: (context) =>
          SignupviewModel(AuthService(), DatabaseServices(), StorageService()),
      child: Consumer<SignupviewModel>(builder: (context, model, _) {
        return Scaffold(
          body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  40.verticalSpace,
                  Text("Create your account", style: h),
                  5.verticalSpace,
                  Text("Please provide the details",
                      style: body.copyWith(color: grey)),
                  30.verticalSpace,
                  InkWell(
                    onTap: () {
                      model.pickImage();
                    },
                    child: model.image == null
                        ? CircleAvatar(
                            radius: 40.r,
                            child: const Icon(Icons.camera_alt),
                          )
                        : CircleAvatar(
                            radius: 40.r,
                            backgroundImage: FileImage(model.image!),
                          ),
                  ),
                  20.verticalSpace,
                  CustomTextfield(
                    hintText: "Enter Name",
                    onChanged: model.setName,
                  ),
                  20.verticalSpace,
                  CustomTextfield(
                    hintText: "Enter Email",
                    onChanged: model.setEmail,
                  ),
                  20.verticalSpace,
                  CustomTextfield(
                    hintText: "Enter Password",
                    onChanged: model.setPassword,
                    isPassword: true,
                  ),
                  20.verticalSpace,
                  CustomTextfield(
                    hintText: "Confirm Password",
                    onChanged: model.setConfirmPassword,
                    isPassword: true,
                  ),
                  30.verticalSpace,
                  CustomButton(
                      loading: model.state == ViewState.loading,
                      onPressed: model.state == ViewState.loading
                          ? null
                          : () async {
                              final messenger = ScaffoldMessenger.of(context);
                              final navigator = Navigator.of(context);
                              try {
                                await model.signup();
                                messenger.showSnackBar(
                                    const SnackBar(content: Text("User signed up successfully!")));

                                navigator.pop();
                              } on FirebaseAuthException catch (e) {
                                messenger.showSnackBar(SnackBar(content: Text(e.toString())));
                              } catch (e) {
                                messenger.showSnackBar(SnackBar(content: Text(e.toString())));
                              }
                            },
                      text: "Sign Up"),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have account? ",
                        style: body.copyWith(color: grey),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, login);
                          },
                          child: Text("Login",
                              style: body.copyWith(fontWeight: FontWeight.bold)))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
