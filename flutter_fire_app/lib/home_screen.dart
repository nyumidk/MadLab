import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // PART 2: capture input with a controller.
  final _controller = TextEditingController();

  // PART 3: a reference to the "notes" node in the Realtime Database.
  final _dbRef = FirebaseDatabase.instance.ref('notes');

  // PART 3: push() creates a unique child key, set() writes the value.
  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    await _dbRef.push().set({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
    });
    _controller.clear();
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Saved to Firebase ✅')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Notes'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PART 2: TextField + Submit button.
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Note',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _submit, child: const Text('Submit')),
            ),
            const SizedBox(height: 24),
            const Text('Saved Notes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            Expanded(child: _buildList()),
          ],
        ),
      ),
    );
  }

  // PART 4: StreamBuilder + .onValue keeps the list updated in
  // real time, with loading and error states handled explicitly.
  Widget _buildList() {
    return StreamBuilder<DatabaseEvent>(
      stream: _dbRef.onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('⚠️ ${snapshot.error}', style: const TextStyle(color: Colors.red)),
          );
        }
        final raw = snapshot.data?.snapshot.value;
        if (raw == null) {
          return const Center(child: Text('No notes yet — add one above.'));
        }

        final map = Map<String, dynamic>.from(raw as Map);
        final entries = map.entries.toList()
          ..sort((a, b) => '${b.value['createdAt']}'.compareTo('${a.value['createdAt']}'));

        return ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, i) {
            final note = Map<String, dynamic>.from(entries[i].value as Map);
            return ListTile(
              leading: const Icon(Icons.notes),
              title: Text('${note['text']}'),
              subtitle: Text('${note['createdAt']}'),
            );
          },
        );
      },
    );
  }
}