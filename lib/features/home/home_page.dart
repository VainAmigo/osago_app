import 'package:flutter/material.dart';
import 'package:osago_bloc_app/features/home/cars_page.dart';
import 'package:osago_bloc_app/features/home/polis_screen.dart';

import '../../common/localization/language_constants.dart';
import 'emergency/emergency_screen.dart';
import 'services_page.dart';
import 'settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  final pages = [
    PolisScreen(),
    CarsPage(),
    EmergencyScreen(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,

        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),

        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: translation(context).navigationBarPolicy,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.car_crash),
            label: translation(context).navigationBarCars,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.security_rounded),
            label: translation(context).navigationBarService,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: translation(context).navigationBarSettings,
          ),
        ],
      ),
    );
  }
}
