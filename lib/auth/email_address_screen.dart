import 'package:flutter/material.dart';

import 'pin_verification.dart';

class EmailAddressScreen extends StatefulWidget {
  const EmailAddressScreen({super.key});

  @override
  State<EmailAddressScreen> createState() => _EmailAddressScreenState();
}

class _EmailAddressScreenState extends State<EmailAddressScreen> {
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
                'Your Email Address',
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
                decoration: const InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PinVerifyScreen(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.arrow_circle_right_outlined, size: 30)],
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have a account?"),
                  TextButton(onPressed: () {}, child: const Text('Sign In')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
