import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/components/top_text_block.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/home/settings/local_selection_page.dart';

import '../../../../../common/components/my_text_button.dart';
import '../../../../../common/components/my_text_field.dart';
import '../../cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;

  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();
  final innController = TextEditingController();

  // void fetchPersonDoc() {
  //   final personDocCubit = context.read<PersonDocCubit>();
  //   personDocCubit.fetchPersonDocByInn(innController.text);
  // }

  // register button pressed
  void register() {
    final String email = emailController.text;
    final String pw = pwController.text;
    final String confirmPw = confirmPwController.text;
    final String inn = innController.text;

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    // ensure that text fields is not empty
    if (email.isNotEmpty &&
        pw.isNotEmpty &&
        confirmPw.isNotEmpty &&
        inn.isNotEmpty) {
      if (pw == confirmPw) {
        authCubit.register(inn, email, pw);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                translation(context).authRegistrationErrorMessageNotMatch)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              translation(context).authRegistrationErrorMessageNotCompFields)));
    }
  }

  @override
  void dispose() {
    innController.dispose();
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LanguageSelectionPage())),
            icon: Icon(Icons.language, color: Theme.of(context).colorScheme.tertiary,),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topTextBlock(
                  title: translation(context).authRegistrationTopTitle,
                  text: translation(context).authRegistrationTopText,
                ),
                SizedBox(height: 24),
                MyTextField(
                  controller: emailController,
                  hintText: translation(context).authRegistrationInputEmail,
                  obscureText: false,
                ),
                SizedBox(height: 12),
                MyTextField(
                  controller: pwController,
                  hintText: translation(context).authRegistrationInputPass,
                  obscureText: true,
                ),
                SizedBox(height: 12),
                MyTextField(
                  controller: confirmPwController,
                  hintText:
                      translation(context).authRegistrationInputPassConfirm,
                  obscureText: true,
                ),
                SizedBox(height: 12),
                MyTextField(
                  controller: innController,
                  hintText: translation(context).authRegistrationInputEnterInn,
                  obscureText: false,
                ),
                SizedBox(height: 12),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyButton(
                        text: translation(context).buttonRegistration,
                        onPress: register),
                    SizedBox(height: 8),
                    MyTextButton(
                      text:
                          translation(context).authTextButtonAlreadyHaveAccount,
                      onTap: widget.togglePage,
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
