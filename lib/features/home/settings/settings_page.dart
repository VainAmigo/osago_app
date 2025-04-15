import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/common/theme/theme_cubit.dart';
import 'package:osago_bloc_app/features/auth/presentation/pages/pass/change_pass_page.dart';
import 'package:osago_bloc_app/features/home/components/settings_button.dart';
import 'package:osago_bloc_app/features/home/settings/local_selection_page.dart';
import 'package:osago_bloc_app/features/home/settings/personal_info.dart';

import '../../auth/presentation/cubits/auth_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    late final authCubit = context.read<AuthCubit>();

    // theme
    final themeCubit = context.watch<ThemeCubit>();

    // is dark mode
    bool isDarkMode = themeCubit.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).settingsAppBarTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // settings list
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Column(
                children: [
                  SettingsButton(
                    icon: Icons.person,
                    text: translation(context).settingsPersonalData,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalInfo(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    height: 0,
                    thickness: 2,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  SettingsButton(
                    icon: Icons.lock,
                    text: translation(context).settingsChangePass,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordPage(),
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 2,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.account_box,
                                color: Theme.of(context).colorScheme.primary),
                            SizedBox(width: 8),
                            Text(
                              translation(context).settingsTheme,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        CupertinoSwitch(
                          value: isDarkMode,
                          onChanged: (value) {
                            themeCubit.toggleTheme();
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 2,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  SettingsButton(
                    icon: Icons.language,
                    text: translation(context).settingsLanguage,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguageSelectionPage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // logout button
            InkWell(
              onTap: authCubit.logout,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  translation(context).buttonExit,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
