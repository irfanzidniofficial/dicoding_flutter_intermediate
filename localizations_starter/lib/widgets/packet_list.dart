import 'package:flutter/material.dart';
import 'package:localizations_starter/content/free_packet_card.dart';
import 'package:localizations_starter/content/or_widget.dart';
import 'package:localizations_starter/content/paid_packet_card.dart';
import 'package:localizations_starter/widgets/max_width_widget.dart';

class PackageList extends StatelessWidget {
  const PackageList({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isPotrait = orientation == Orientation.portrait;

    return MaxWidthWidget(
      maxWidth: 600,
      child: isPotrait
          ? const Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PaidPackageCard(),
                OrWidget(),
                FreePackageCard(),
              ],
            )
          : const IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: PaidPackageCard()),
                  OrWidget(),
                  Expanded(child: FreePackageCard()),
                ],
              ),
            ),
    );
  }
}
