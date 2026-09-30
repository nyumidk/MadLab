import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Handles everything to do with the saved note file.
///
/// dart:io's File and path_provider only work on Android, iOS, and
/// desktop — a browser has no direct filesystem access. So on web,
/// this falls back to SharedPreferences (backed by localStorage)
/// while keeping the exact same three methods the UI calls.
class FileHelper {
  static const _fileName = 'notes.txt';
  static const _webKey = 'notes_txt';

  // PART 2: getApplicationDocumentsDirectory() locates a private,
  // writable folder for this app — native platforms only.
  static Future<Directory> get documentsDirectory =>
      getApplicationDocumentsDirectory();

  static Future<File> get _file async {
    final dir = await documentsDirectory;
    return File('${dir.path}/$_fileName');
  }

  /// Exposed so the UI can print/display the resolved path.
  static Future<String> get filePath async {
    if (kIsWeb) return 'Browser storage (no filesystem on web)';
    return (await _file).path;
  }

  // PART 3: create/overwrite and write text to the file.
  static Future<void> writeNote(String contents) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_webKey, contents);
      return;
    }
    final file = await _file;
    await file.writeAsString(contents);
  }

  // PART 3 + 4: read the file back; throw a clear error if there's
  // nothing saved yet so the UI can handle it gracefully.
  static Future<String> readNote() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(_webKey);
      if (value == null) {
        throw Exception('No saved note yet — write one first.');
      }
      return value;
    }
    try {
      final file = await _file;
      if (!await file.exists()) {
        throw Exception('No saved note yet — write one first.');
      }
      return await file.readAsString();
    } on FileSystemException {
      throw Exception('Could not access the file (permission or I/O error).');
    }
  }
}