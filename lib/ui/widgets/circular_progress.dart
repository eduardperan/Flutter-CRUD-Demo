import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final bool _show;

  CircularProgress(this._show);

  @override
  Widget build(BuildContext context) {
    if (_show) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}
