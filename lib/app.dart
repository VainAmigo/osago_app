import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/common/theme/theme_cubit.dart';
import 'package:osago_bloc_app/features/cars/data/firebase_car_repo.dart';
import 'package:osago_bloc_app/features/cars/presentation/cubits/car_cubit.dart';
import 'package:osago_bloc_app/features/home/home_page.dart';
import 'package:osago_bloc_app/features/osago/data/firebase_osago_repo.dart';
import 'package:osago_bloc_app/features/osago/presentation/cubits/osago_cubit.dart';
import 'package:osago_bloc_app/features/tunduc/data/firebase_person_doc_repo.dart';
import 'package:osago_bloc_app/features/tunduc/presentation/cubits/person_doc_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'common/localization/language_constants.dart';
import 'features/auth/data/firebase_auth_repo.dart';
import 'features/auth/presentation/cubits/auth_cubit.dart';
import 'features/auth/presentation/cubits/auth_states.dart';
import 'features/auth/presentation/pages/auth_page.dart';

class MyApp extends StatefulWidget {

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void initState() {
    super.initState();
    _loadLocale();
  }

  void _loadLocale() async {
    Locale locale = await getLocale(); // из shared_preferences
    setState(() {
      _locale = locale;
    });
  }


  // auth repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  final firebaseOsagoRepo = FirebaseOsagoRepo();

  final firebaseCarRepo = FirebaseCarRepo();

  final firebasePersonDocRepo = FirebasePersonDocRepo();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // provider cubit to app
    return MultiBlocProvider(
      providers: [
        //auth cubit
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),

        // osago cubit
        BlocProvider<OsagoCubit>(
          create: (context) => OsagoCubit(
            osagoRepo: firebaseOsagoRepo,
          ),
        ),

        // personDoc cubit
        BlocProvider<PersonDocCubit>(
          create: (context) => PersonDocCubit(
            personDocRepo: firebasePersonDocRepo,
          ),
        ),

        // car cubit
        BlocProvider<CarCubit>(
          create: (context) => CarCubit(
            carRepo: firebaseCarRepo,
          ),
        ),

        // theme cubit
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],

      // check current theme
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, currentTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: currentTheme,

          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,

          // check current user
          home: BlocConsumer<AuthCubit, AuthState>(
            builder: (context, authState) {
              print(authState);

              if (authState is Unauthenticated) {
                return const AuthPage();
              }
              if (authState is Authenticated) {
                return const HomePage();
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
            listener: (context, authState) {
              if (authState is AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(authState.message)));
              }
            },
          ),
        ),
      ),
    );
  }
}
