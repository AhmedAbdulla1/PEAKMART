import 'package:flutter/material.dart';

class MoreItem extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback? onPressed;

  const MoreItem({
    super.key,
    required this.image,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            shadowColor: Colors.transparent,
            // onSurface: Theme.of(context).accentColor,
          ),
          onPressed: onPressed ?? () {},
          child: ListTile(
            leading: Image.asset(
              image,
              color: Theme.of(context).primaryColor,
              height: 30,
            ),
            title: Text(
              title,
            textScaler : const TextScaler.linear(1),
              // style: getIt<AppTextStyles>().headline5,
            ),
          ),
        ),
        const Divider(
          indent: 1,
        ),
      ],
    );
  }
}
