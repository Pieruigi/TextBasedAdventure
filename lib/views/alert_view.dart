import 'package:flutter/material.dart';

class AlertView extends StatelessWidget {
  const AlertView({Key? key, required this.callback}) : super(key: key);

  final Function<int>(bool) callback;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
