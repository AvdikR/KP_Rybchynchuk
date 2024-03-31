import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:what_u_cread/core/app_export.dart';
import 'package:what_u_cread/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class AppbarTrailingImage extends StatelessWidget{
  AppbarTrailingImage({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(key: key,);

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          imagePath: imagePath,
          height: 24.adaptSize,
          width: 24.adaptSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}