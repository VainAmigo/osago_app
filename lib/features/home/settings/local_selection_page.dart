import 'package:flutter/material.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';

import '../../../app.dart';

class Language {
  final String code;
  final String name;
  final Locale locale;

  Language({
    required this.code,
    required this.name,
    required this.locale,
  });
}

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({Key? key}) : super(key: key);

  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  Locale? selectedLocale;

  final List<Language> languages = [
    Language(code: 'ky', name: 'Кыргызча', locale: Locale('ky')),
    Language(code: 'ru', name: 'Русский', locale: Locale('ru')),
    Language(code: 'en', name: 'English', locale: Locale('en')),
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  void _loadSelectedLanguage() async {
    Locale currentLocale = await getLocale();
    setState(() {
      selectedLocale = currentLocale;
    });
  }


  void _selectLanguage(Language language) {
    setState(() {
      selectedLocale = language.locale;
    });

    MyApp.setLocale(context, language.locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text(
          translation(context).settingsLanguageAppBarTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: languages.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final language = languages[index];
              final isSelected = selectedLocale?.languageCode == language.code;

              return ListTile(
                title: Text(
                  language.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                trailing: isSelected
                    ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                    : null,
                onTap: () => _selectLanguage(language),
              );
            },
          ),
        ),
      ),
    );
  }
}
