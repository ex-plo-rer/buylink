import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({
    Key? key,
    this.width,
  }) : super(key: key);

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: width,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
