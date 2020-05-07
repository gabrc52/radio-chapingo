import 'package:flutter/material.dart';

class PodcastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Por el momento, no hay podcasts disponibles',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
