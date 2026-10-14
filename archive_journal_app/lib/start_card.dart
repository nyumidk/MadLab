import 'package:flutter/material.dart';

import 'theme.dart';

/// The dashed "Start Writing" card; also serves as the empty state.
class StartWritingCard extends StatelessWidget {
  const StartWritingCard({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(),
        child: Container(
          height: 260,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.peach,
                child: Icon(Icons.add, size: 30, color: AppColors.brown),
              ),
              const SizedBox(height: 16),
              Text('Start Writing', style: titleStyle.copyWith(fontSize: 18)),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Capture the ephemeral moments of today.',
                  textAlign: TextAlign.center,
                  style: bodyStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.peach
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Offset.zero & size, const Radius.circular(12)));
    for (final metric in path.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 6), paint);
        d += 12;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
