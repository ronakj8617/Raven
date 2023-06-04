import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../appwrite/auth_api.dart';
import './login_page.dart';
import './tabs_page.dart';

void main() {
  // runApp(const MyApp());
  runApp(ChangeNotifierProvider(
      create: ((context) => AuthAPI()), child: const TempMain()));
}

class TempMain extends StatelessWidget {
  const TempMain({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.watch<AuthAPI>().status;
    print('TOP CHANGE Value changed to: $value!');

    return MaterialApp(
        title: 'Appwrite Auth Demo',
        debugShowCheckedModeBanner: false,
        home: value == AuthStatus.uninitialized
            ? const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : value == AuthStatus.authenticated
                ? const TabsPage()
                : const LoginPage(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFFE91052),
          ),
        ));
  }
}
