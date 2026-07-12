import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'set_password.dart';

class PinVerifyScreen extends StatefulWidget {
  const PinVerifyScreen({super.key});

  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pin Verification',
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
              MaterialPinField(
                length: 6,
                onCompleted: (pin) => print('PIN: $pin'),
                onChanged: (value) => print('Changed: $value'),
                theme: MaterialPinTheme(
                  shape: MaterialPinShape.outlined,
                  cellSize: Size(50, 60),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SetPasswordScreen(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Verify'),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_circle_right_outlined),
                  ],
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
