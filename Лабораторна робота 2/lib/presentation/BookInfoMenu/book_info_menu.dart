import 'package:what_u_cread/widgets/custom_bottom_bar.dart';
import 'package:what_u_cread/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:what_u_cread/core/app_export.dart';

// ignore_for_file: must_be_immutable
class BookInfoMenu extends StatelessWidget {
  BookInfoMenu({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static int chapterNumber = 1;
  static int? chapterAmount;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                height: 753.v,
                width: double.maxFinite,
                child: Stack(alignment: Alignment.topCenter, children: [
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 86.v),
                          decoration: AppDecoration.fillGray200,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Spacer(),
                                _buildChapterList(context),
                                SizedBox(height: 63.v),
                                SizedBox(
                                    width: 135.h,
                                    child: Text(
                                        "Date of last Upload\n17.03.2023",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodyMedium))
                              ]))),
                  _buildHeaderPanel(context)
                ])),
            floatingActionButton: _buildFloatingActionButton(context)));
  }

  /// Section Widget
  Widget _buildChapterList(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 7.v),
        decoration: AppDecoration.fillBluegray100
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder20),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Chapter List", style: theme.textTheme.bodyMedium),
              SizedBox(height: 3.v),
              SizedBox(
                  height: 272.v,
                  width: 342.h,
                  child: Stack(alignment: Alignment.center, children: [
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.only(left: 5.h, right: 7.h),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        OnTapChapterNumber(chapterNumber);
                                      },
                                      child: Container(
                                          width: 330.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 11.h, vertical: 7.v),
                                          decoration: AppDecoration
                                              .outlineBlack9001
                                              .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder5),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 3.v),
                                                Text(
                                                    "Chapter 1                              10.06.2021",
                                                    style: theme
                                                        .textTheme.bodyMedium)
                                              ]))),
                                  SizedBox(height: 3.v),
                                  Container(
                                      width: 330.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11.h, vertical: 7.v),
                                      decoration: AppDecoration.outlineBlack9001
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder5),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 3.v),
                                            Text(
                                                "Chapter 2                              12.01.2022",
                                                style:
                                                    theme.textTheme.bodyMedium)
                                          ])),
                                  SizedBox(height: 3.v),
                                  Container(
                                      width: 330.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11.h, vertical: 7.v),
                                      decoration: AppDecoration.outlineBlack9001
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder5),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 3.v),
                                            Text(
                                                "Chapter 3                              12.03.2022",
                                                style:
                                                    theme.textTheme.bodyMedium)
                                          ])),
                                  SizedBox(height: 3.v),
                                  Container(
                                      width: 330.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11.h, vertical: 7.v),
                                      decoration: AppDecoration.outlineBlack9001
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder5),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 3.v),
                                            Text(
                                                "Chapter 4                              29.03.2022",
                                                style:
                                                    theme.textTheme.bodyMedium)
                                          ])),
                                  SizedBox(height: 3.v),
                                  Container(
                                      width: 330.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11.h, vertical: 7.v),
                                      decoration: AppDecoration.outlineBlack9001
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder5),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 3.v),
                                            Text(
                                                "Chapter 5                              12.01.2023",
                                                style:
                                                    theme.textTheme.bodyMedium)
                                          ])),
                                  SizedBox(height: 3.v),
                                  Container(
                                      width: 330.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11.h, vertical: 7.v),
                                      decoration: AppDecoration.outlineBlack9001
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder5),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 3.v),
                                            Text(
                                                "Chapter 6                              17.03.2023",
                                                style:
                                                    theme.textTheme.bodyMedium)
                                          ])),
                                  SizedBox(height: 3.v),
                                  SizedBox(
                                      height: 24.v,
                                      width: 330.h,
                                      child: Stack(
                                          alignment: Alignment.bottomLeft,
                                          children: [
                                            Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                    height: 37.v,
                                                    width: 330.h,
                                                    decoration: BoxDecoration(
                                                        color: appTheme.gray400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.h),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: appTheme
                                                                  .black900
                                                                  .withOpacity(
                                                                      0.25),
                                                              spreadRadius: 2.h,
                                                              blurRadius: 2.h,
                                                              offset:
                                                                  Offset(0, 4))
                                                        ]))),
                                            Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 11.h),
                                                    child: Text(
                                                        "Chapter 7                              17.03.2023",
                                                        style: theme.textTheme
                                                            .bodyMedium)))
                                          ]))
                                ]))),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 272.v,
                            width: 342.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.h),
                                border: Border.all(
                                    color: appTheme.gray60002, width: 4.h))))
                  ])),
              SizedBox(height: 2.v)
            ]));
  }

  /// Section Widget
  Widget _buildHeaderPanel(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
            height: 249.v,
            width: double.maxFinite,
            child: Stack(alignment: Alignment.topCenter, children: [
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.only(left: 3.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.h, vertical: 19.v),
                      decoration: AppDecoration.fillBlueGray,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 141.v, bottom: 6.v),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Author: Name_Of_Author",
                                          style: CustomTextStyles
                                              .bodyMediumWhiteA700),
                                      SizedBox(height: 3.v),
                                      Text("Publisher: Name_Of_Publisher",
                                          style: CustomTextStyles
                                              .bodyMediumWhiteA700),
                                      SizedBox(height: 3.v),
                                      Text("Genres: list_of_genres",
                                          style: theme.textTheme.bodyMedium)
                                    ])),
                            Container(
                                height: 67.adaptSize,
                                width: 67.adaptSize,
                                margin:
                                    EdgeInsets.only(top: 144.v, right: 17.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 9.h, vertical: 11.v),
                                decoration: AppDecoration.outlineBlack9002
                                    .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder33),
                                child: CustomImageView(
                                    imagePath: ImageConstant.imageNotFound,
                                    height: 43.v,
                                    alignment: Alignment.center))
                          ]))),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      decoration: AppDecoration.outlineGray.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder20),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: EdgeInsets.only(left: 63.h),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                          imagePath: ImageConstant.imgBookcover,
                                          height: 98.v,
                                          radius: BorderRadius.circular(30.h)),
                                      CustomImageView(
                                          imagePath: ImageConstant.imgGlobe,
                                          height: 1.v,
                                          margin: EdgeInsets.only(
                                              left: 8.h, bottom: 98.v))
                                    ]))),
                        SizedBox(height: 6.v),
                        Text("Book Name",
                            style: CustomTextStyles.bodyLargeBlack90018),
                        SizedBox(height: 5.v)
                      ])))
            ])));
  }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
        height: 60,
        width: 60,
        backgroundColor: appTheme.blueGray100,
        child: CustomImageView(imagePath: ImageConstant.img2630511));
  }


  OnTapChapterNumber(int chapterNumber){
    
  }
}
