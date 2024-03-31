import 'package:what_u_cread/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:what_u_cread/core/app_export.dart';

// ignore: must_be_immutable
class MainWindowWidget extends StatelessWidget {
  MainWindowWidget({
    Key? key,
    this.onTapContent,
  }) : super(
          key: key,
        );

  VoidCallback? onTapContent;

  static int? bookID;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapContent?.call();
      },
      child: SizedBox(
        height: 180.v,
        width: 157.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgRectangle11,
              width: 156.h,
              radius: BorderRadius.circular(
                5.h,
              ),
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(right: 1.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNameofbook1(context),
                    SizedBox(
                      height: 139.v,
                      width: 140.h,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgBookcover,
                            width: 135.h,
                            radius: BorderRadius.circular(
                              5.h,
                            ),
                            alignment: Alignment.center,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 98.h,
                              child: Text(
                                "  Num_Chapter1   \nUser1    1h ago",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.bodyMedium14,
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgEllipse1,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                            radius: BorderRadius.circular(
                              10.h,
                            ),
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 7.v),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNameofbook1(BuildContext context) {
    bookID = 1;
    return CustomElevatedButton(
      width: 156.h,
      text: "Name_of_book1",

    );
  }
}
