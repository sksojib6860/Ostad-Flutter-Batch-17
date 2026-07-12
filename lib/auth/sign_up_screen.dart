import 'package:flutter/material.dart';
import 'package:task_manager_app/auth/email_address_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                'Join with us',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(hintText: 'First Name'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Last Name'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Password'),
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmailAddressScreen(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Join Now'),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_circle_right_outlined, size: 30),
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
