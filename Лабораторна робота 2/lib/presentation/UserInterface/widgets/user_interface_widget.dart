
import 'package:flutter/cupertino.dart';
import 'package:what_u_cread/core/app_export.dart';
import 'package:what_u_cread/theme/app_decoration.dart';
import 'package:what_u_cread/theme/custom_text_style.dart';
import 'package:what_u_cread/widgets/custom_image_view.dart';

class ReadingBooklistWidget extends StatelessWidget{
  const ReadingBooklistWidget({Key? key})
      : super(
          key: key,  
        );

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 22.v,
      ),
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgBookIcon,
                height: 50.adaptSize,
                width: 50.adaptSize,
                radius: BorderRadius.circular(25.h)
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.h,
                  top: 7.v,
                  bottom: 3.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name_book1",
                      style: CustomTextStyles.bodyLargeBlack90018,
                    ),
                    SizedBox(height: 4.v),
                    Text(
                      "1 day ago",
                      style: CustomTextStyles.bodyMedium14,
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgSettingsearching,
                height: 6.v,
                margin: EdgeInsets.symmetric(vertical: 22.v)
              )
            ],
          ),
          SizedBox(height: 18.v),
          Container(
            width: 332.h,
            margin: EdgeInsets.only(right: 17.h),
            child: Text(
              "Added new chapter: chapter 15",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyMedium14.copyWith(
                height: 1.50,
              ),
            ),
          ),
        ]),

    );
  }
}