import 'package:flutter/material.dart';

class PromotionalBanners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.local_offer),
        title: Text('Offers and Tips'),
        subtitle: Text('Check out the latest offers!'),
        trailing: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // Dismiss banner
          },
        ),
      ),
    );
  }
}
