import 'package:actual/riverpodsample/layout/default_layout.dart';
import 'package:actual/riverpodsample/screen/state_notifier_provider_screen.dart';
import 'package:actual/riverpodsample/screen/state_provider_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'HomeScreen',
        body: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StateProviderScreen()),
                  );
                },
                child: Text("StateProviderScreen")),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StateNotifierProviderScreen(),
                  ),
                );
              },
              child: Text("StateNotifierProvider"),
            ),
          ],
        ));
  }
}
