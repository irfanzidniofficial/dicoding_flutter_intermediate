import 'package:flutter/material.dart';
import 'package:localizations_starter/content/benefit_widget.dart';
import 'package:localizations_starter/content/header_widget.dart';
import 'package:localizations_starter/widgets/max_width_widget.dart';
import 'package:localizations_starter/widgets/packet_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/dicoding-academy.png"),
        ),
        title: const Text("Dicoding Academy"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.flag),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const MaxWidthWidget(
        maxWidth: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CostWidget(),
              PackageList(),
              SizedBox(height: 20),
              BenefitWidget(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
