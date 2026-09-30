import 'package:flutter/material.dart';
import 'second_screen.dart';
const _imageUrl =
    'https://images.unsplash.com/photo-1585109649139-366815a0d713?auto=format&fit=crop&w=900&q=80';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _snack(BuildContext c, String msg) =>
      ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(msg)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crunch & Cheese'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hungry? 🍟',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('Today\'s top pick from The Fry House'),
            const SizedBox(height: 16),
            // Tap -> explore restaurant (named route).
            // Double-tap -> quick add to cart. Long-press -> ingredients.
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/details'),
              onDoubleTap: () => _snack(context, 'Cheesy Fries added to cart 🛒'),
              onLongPress: () =>
                  _snack(context, 'Loaded with mozzarella, cheddar & jalapeños 🧀'),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(children: [
                  Image.network(_imageUrl,
                      height: 200, width: double.infinity, fit: BoxFit.cover),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cheesy Fries',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('The Fry House · ₹149'),
                          ],
                        ),
                      ),
                      Icon(Icons.local_fire_department, color: Colors.deepOrange),
                    ]),
                  ),
                ]),
              ),
            ),
            const Text('Quick Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SecondScreen())),
                  icon: const Icon(Icons.storefront),
                  label: const Text('Explore Restaurant'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _snack(context, 'Added to cart 🛒'),
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Add to Cart'),
                ),
              ),
            ]),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.deepOrange.shade50,
                  borderRadius: BorderRadius.circular(16)),
              child: const Row(children: [
                Icon(Icons.touch_app, size: 32),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Tap to view the restaurant.\n'
                    'Double-tap to add to cart, long-press for ingredients.',
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}