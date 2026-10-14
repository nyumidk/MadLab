import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'note.dart';
import 'theme.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, this.torn = false, this.onTap});

  final Note note;
  final bool torn; // torn-paper bottom edge
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 20, 20, torn ? 30 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: torn ? null : BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(spacing: 8, runSpacing: 6, children: [
            _Chip(DateFormat('MMM d, yyyy').format(note.createdAt)),
            if (note.collection.isNotEmpty) _Chip(note.collection),
          ]),
          const SizedBox(height: 14),
          Text(note.title.isEmpty ? 'Untitled' : note.title, style: titleStyle),
          if (note.body.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(note.body,
                maxLines: 7, overflow: TextOverflow.ellipsis, style: bodyStyle),
          ],
          if (note.imageUrl != null) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                note.imageUrl!,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => const SizedBox.shrink(),
              ),
            ),
          ],
        ],
      ),
    );
    return GestureDetector(
      onTap: onTap,
      child: torn
          ? ClipPath(clipper: const TornEdgeClipper(), child: content)
          : content,
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.peach,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          color: AppColors.darkBrown,
        ),
      ),
    );
  }
}

/// Zig-zag cut along the bottom edge, like torn paper.
class TornEdgeClipper extends CustomClipper<Path> {
  const TornEdgeClipper();

  @override
  Path getClip(Size size) {
    const tooth = 8.0;
    final path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - tooth);
    var x = size.width;
    var down = true;
    while (x > 0) {
      x = math.max(x - tooth, 0);
      path.lineTo(x, down ? size.height : size.height - tooth);
      down = !down;
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
