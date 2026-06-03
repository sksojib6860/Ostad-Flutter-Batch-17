import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final List<Map<String, String>> _contacts = [];

  void _addContact() {
    final String name = _nameController.text.trim();
    final String number = _numberController.text.trim();

    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        _contacts.add({'name': name, 'number': number});
      });
      _nameController.clear();
      _numberController.clear();
    }
  }

  void _deleteContact(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to delete this contact?'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.cancel, color: Colors.blue),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _contacts.removeAt(index);
              });
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete_outline, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF5C7A8A),
        title: const Text('Contact List', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C7A8A),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _addContact,
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[200],
                    child: ListTile(
                      onLongPress: () => _deleteContact(index),
                      leading: const Icon(Icons.person, color: Colors.brown, size: 40),
                      title: Text(
                        _contacts[index]['name']!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(_contacts[index]['number']!),
                      trailing: const Icon(Icons.phone, color: Colors.blue),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
