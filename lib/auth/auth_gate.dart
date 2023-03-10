import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:uptime/screens/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs: const [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                  clientId:
                      '831484884477-nvrfoo66mscv7qa0ka0rtbgkg8c7v2mo.apps.googleusercontent.com'),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return AspectRatio(
                aspectRatio: 1,
                child: FadeInImage.assetNetwork(
                  placeholder: 'images/loading.gif',
                  image: 'images/computer_transparent.png',
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to Uptime Champ, please sign in!')
                    : const Text('Welcome to Uptime Champ, please register!'),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return AspectRatio(
                aspectRatio: 1,
                child: Image.asset('images/computer_transparent.png',
                    fit: BoxFit.fill),
              );
            },
          );
        }

        return const Home(
          title: 'Uptime Champ',
        );
      },
    );
  }
}
