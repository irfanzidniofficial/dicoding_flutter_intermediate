import 'package:flutter/material.dart';

import '../model/quote.dart';

class QuotesListScreen extends StatelessWidget {
  final List<Quote> quotes;

  const QuotesListScreen({
    super.key,
    required this.quotes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes App"),
      ),
      body: ListView(
        children: [
          for (var quote in quotes)
            ListTile(
              title: Text(quote.author),
              subtitle: Text(quote.quote),
              isThreeLine: true,
            )
        ],
      ),
    );
  }
}
