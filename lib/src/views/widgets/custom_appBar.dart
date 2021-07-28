import 'package:flutter/material.dart';
import 'package:framer/src/utils/colors.dart';


PreferredSizeWidget customAppBar({context, String? title}) {
  return AppBar(
    title: Text(
      title!,
      style: Theme.of(context).textTheme.headline6,
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          size: 24,
          color: DARK_COLOR,
        )),
  );
}
