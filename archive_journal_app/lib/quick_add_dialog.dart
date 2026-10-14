import 'package:flutter/material.dart';

import 'note_service.dart';

Future<void> showQuickAdd(BuildContext context) =>
    showDialog<void>(context: context, builder: (_) => const _QuickAddDialog());

class _QuickAddDialog extends StatefulWidget {
  const _QuickAddDialog();

  @override
  State<_QuickAddDialog> createState() => _QuickAddDialogState();
}

class _QuickAddDialogState extends State<_QuickAddDialog> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  final _image = TextEditingController();
  String? _error;
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    _image.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_title.text.trim().isEmpty && _body.text.trim().isEmpty) {
      setState(() => _error = 'Write something first.');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await noteService.add(
        title: _title.text.trim(),
        body: _body.text.trim(),
        imageUrl: _image.text.trim(),
      );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = 'Could not save: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New note'),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _body,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Write here…'),
              ),
              TextField(
                controller: _image,
                decoration:
                    const InputDecoration(labelText: 'Image URL (optional)'),
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Saving…' : 'Save'),
        ),
      ],
    );
  }
}
