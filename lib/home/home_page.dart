import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                      labelText: 'Task',
                      hintText: 'Add Task',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                  leading: Checkbox(value: false, onChanged: (value) {}),
                  title: Text('Task $index'),
                  shape: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),

                  trailing: Row(
                    mainAxisSize: .min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        color: Colors.orange.shade300,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
