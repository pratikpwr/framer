import 'package:flutter/material.dart';
import 'package:framer/src/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  CustomButton(this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.button,
        ),
      ),
      onTap: onTap,
    );
  }
}
