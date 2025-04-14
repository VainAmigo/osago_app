import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/components/my_text_button.dart';
import 'package:osago_bloc_app/common/components/my_text_field.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/auth/presentation/cubits/auth_cubit.dart';

import '../../../../../common/components/top_text_block.dart';
import '../../../../home/settings/local_selection_page.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePage;

  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  // login button pressed
  void login() {
    final String email = emailController.text;
    final String pw = pwController.text;

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    // ensure that email and pw not empty
    if (email.isNotEmpty && pw.isNotEmpty) {
      authCubit.login(email, pw);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translation(context).authLoginErrorMessageNotCompFields),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
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
                  title: translation(context).authLoginTopTitle,
                  text: translation(context).authLoginTopText,
                ),
                SizedBox(height: 24),
                MyTextField(
                  controller: emailController,
                  hintText: translation(context).authLoginInputEnterEmail,
                  obscureText: false,
                ),
                SizedBox(height: 12),
                MyTextField(
                  controller: pwController,
                  hintText: translation(context).authLoginInputPass,
                  obscureText: true,
                ),
                SizedBox(height: 12),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyButton(text: translation(context).buttonLogin, onPress: login),
                    SizedBox(height: 8),
                    MyTextButton(
                      text: translation(context).authTextButtonDoNotHaveAccount,
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
