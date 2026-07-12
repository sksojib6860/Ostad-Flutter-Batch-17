import 'package:flutter/material.dart';

import 'email_address_screen.dart';
import 'login_page.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set your password',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 30),
              Text(
                'A 4 digit code will be sent to your email address for verification.',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Confirm Password'),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogInPage()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Confirm'),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_circle_right_outlined),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailAddressScreen(),
                        ),
                      );
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
