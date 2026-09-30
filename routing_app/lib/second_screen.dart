import 'package:flutter/material.dart';

const _imageUrl =
    'https://images.unsplash.com/photo-1585109649139-366815a0d713?auto=format&fit=crop&w=900&q=80';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}
class _SecondScreenState extends State<SecondScreen> {
  bool favourite = false;
  int qty = 1;
  void _snack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Fry House'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Double-tap toggles favourite; long-press shows a spice note.
            GestureDetector(
              onDoubleTap: () {
                setState(() => favourite = !favourite);
                _snack(favourite ? 'Saved to favourites ❤️' : 'Removed from favourites');
              },
              onLongPress: () => _snack('Comes with a side of spicy mayo 🌶️'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(_imageUrl,
                    height: 220, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),
            Row(children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cheesy Fries',
                        style:
                            TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    Text('₹149 · The Fry House'),
                  ],
                ),
              ),
              Icon(favourite ? Icons.favorite : Icons.favorite_border,
                  size: 35, color: Colors.deepOrange),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              IconButton(
                onPressed: () => setState(() => qty = qty > 1 ? qty - 1 : 1),
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text('$qty', style: const TextStyle(fontSize: 18)),
              IconButton(
                onPressed: () => setState(() => qty++),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ]),
            const SizedBox(height: 8),
            const Text(
              'Golden fries loaded with melted cheddar, mozzarella and a hint '
              'of jalapeño — served fresh and crunchy, straight from the fryer.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _snack('$qty × Cheesy Fries added to cart 🛒'),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to Cart'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Menu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}