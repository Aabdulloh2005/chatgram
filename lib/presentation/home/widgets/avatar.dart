import 'package:flutter/material.dart';


class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.photo,
    this.radius = 30,
  });

  final String? photo;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    return CircleAvatar(
      radius: radius,
      backgroundImage: photo != null ? NetworkImage(photo) : null,
      child: photo == null
          ?  Icon(Icons.person_outline, size: radius)
          : null,
    );
  }
}
