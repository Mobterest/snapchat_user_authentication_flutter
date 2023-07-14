import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snapkit/snapkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snapchat Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Snapkit _snapkit = Snapkit();
  SnapchatUser? _snapchatUser;
  late StreamSubscription<SnapchatUser?> subscription;

  @override
  void initState() {
    super.initState();

    subscription = _snapkit.onAuthStateChanged.listen((SnapchatUser? user) {
      setState(() {
        _snapchatUser = user;
      });
    });
  }

  Future<void> _loginWithSnapchat(BuildContext context) async {
    await _snapkit.login();

    if (_snapchatUser != null) {
      // User authenticated successfully.
      // You can now navigate to the desired screen or perform further actions.
    } else {
      // Authentication failed.
      // Handle the error accordingly.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snapchat Auth Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(_snapchatUser!.displayName),
            ElevatedButton(
              onPressed: () => _loginWithSnapchat(context),
              child: const Text('Login with Snapchat'),
            ),
          ],
        ),
      ),
    );
  }
}
