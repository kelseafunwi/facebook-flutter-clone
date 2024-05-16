import 'package:flutter/material.dart';

class CreditCardInfo extends StatelessWidget {
  final String cardNumber;
  final String expirationDate;
  final String cardHolderName;

  const CreditCardInfo({
    super.key,
    required this.cardNumber,
    required this.expirationDate,
    required this.cardHolderName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Credit Card Information',
          ),
          const SizedBox(height: 16),
          Text('Card Number: $cardNumber'),
          const SizedBox(height: 8),
          Text('Expiration Date: $expirationDate'),
          const SizedBox(height: 8),
          Text('Card Holder Name: $cardHolderName'),
        ],
      ),
    );
  }
}