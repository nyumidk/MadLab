import 'package:flutter/material.dart';

import 'file_helper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Storage Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller =
      TextEditingController(text: 'Hello from Flutter file storage! 📄');
  Future<String>? _fileContent;
  String _path = '';

  @override
  void initState() {
    super.initState();
    _showPath();
  }

  // PART 2: resolve and display the documents directory path.
  Future<void> _showPath() async {
    try {
      final path = await FileHelper.filePath;
      setState(() => _path = path);
      debugPrint('File path: $path'); // printed to console for verification
    } catch (e) {
      setState(() => _path = 'Could not resolve path: $e');
    }
  }

  // PART 3: write the text field's contents to the file, then
  // immediately queue up a read so the UI reflects what was saved.
  Future<void> _save() async {
    try {
      await FileHelper.writeNote(_controller.text);
      setState(() {
        _fileContent = FileHelper.readNote();
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Saved to device storage ✅')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Save failed: $e')));
    }
  }

  void _load() {
    setState(() {
      _fileContent = FileHelper.readNote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Storage Demo'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Documents directory:',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(_path, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Note text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Write File'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _load,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Read File'),
                ),
              ),
            ]),
            const SizedBox(height: 20),
            const Text('File Content',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  // PART 4: FutureBuilder loads the file asynchronously and shows
  // a loading spinner, an error message, or the styled content.
  Widget _buildContent() {
    if (_fileContent == null) {
      return const Center(
        child: Text('No file read yet. Tap "Write File" or "Read File".'),
      );
    }
    return FutureBuilder<String>(
      future: _fileContent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              '⚠️ ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        }
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              snapshot.data ?? '',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
        );
      },
    );
  }
}