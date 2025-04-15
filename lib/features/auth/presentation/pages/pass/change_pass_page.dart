import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/components/my_text_field.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/auth_states.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  late final authCubit = context.read<AuthCubit>();

  void changePassPressed() {
    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    if (currentPassword.isNotEmpty && newPassword.isNotEmpty) {
      authCubit.reauthenticateAndChangePassword(
        currentPassword,
        newPassword,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).settingsChangePassAppBarTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthPasswordChanged) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translation(context).settingsChangePassSnackBarText),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
            authCubit.logout();
            Navigator.pop(context);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              children: [
                MyTextField(
                  controller: _currentPasswordController,
                  hintText: translation(context).settingsChangePassCurrentPass,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                MyTextField(
                  controller: _newPasswordController,
                  hintText: translation(context).settingsChangePassNewPass,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                const Spacer(),
                MyButton(
                  text: translation(context).buttonChangePassword,
                  onPress: changePassPressed,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
