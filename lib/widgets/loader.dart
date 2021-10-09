import 'package:flutter/material.dart';
import 'package:milestones/shared/constants.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBackground,
      child: const Center(
        child: CircularProgressIndicator(
          color: colorPrimary,
        ),
      ),
    );
  }
}
