import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.add_circle, size: 40),
                onPressed: () {},
              ),
              Text('Add Transaction'),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.swap_horiz, size: 40),
                onPressed: () {},
              ),
              Text('Transfer Money'),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.payment, size: 40),
                onPressed: () {},
              ),
              Text('Pay Bills'),
            ],
          ),
        ],
      ),
    );
  }
}
