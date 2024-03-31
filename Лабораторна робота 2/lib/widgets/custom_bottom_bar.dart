// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:what_u_cread/core/app_export.dart';
import 'package:what_u_cread/theme/app_decoration.dart';
import 'package:what_u_cread/theme/theme_helper.dart';
import 'package:what_u_cread/widgets/custom_image_view.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.img917001,
      activeIcon: ImageConstant.img917001,
      type: BottomBarEnum.tf,
    ),
    BottomMenuModel(
      icon: ImageConstant.img744721,
      activeIcon: ImageConstant.img744721,
      type: BottomBarEnum.tf,
    ),
    BottomMenuModel(
      icon: ImageConstant.img109164138x40,
      activeIcon: ImageConstant.img109164138x40,
      type: BottomBarEnum.x40,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.v,
      decoration: BoxDecoration(
        color: appTheme.gray700,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: SizedBox(
              height: 54.adaptSize,
              width: 54.adaptSize,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 54.adaptSize,
                      width: 54.adaptSize,
                      decoration: BoxDecoration(
                        color: appTheme.blue300,
                        borderRadius: BorderRadius.circular(
                          27.h,
                        ),
                        border: Border.all(
                          color: appTheme.black900,
                          width: 5.h,
                          strokeAlign: strokeAlignCenter,
                        ),
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: bottomMenuList[index].icon,
                    width: 36.h,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.fromLTRB(8.h, 6.v, 10.h, 9.v),
                  ),
                ],
              ),
            ),
            activeIcon: SizedBox(
              height: 54.adaptSize,
              width: 54.adaptSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 54.adaptSize,
                      width: 54.adaptSize,
                      decoration: BoxDecoration(
                        color: appTheme.lightGreen500,
                        borderRadius: BorderRadius.circular(
                          27.h,
                        ),
                        border: Border.all(
                          color: appTheme.black900,
                          width: 5.h,
                          strokeAlign: strokeAlignCenter,
                        ),
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: bottomMenuList[index].activeIcon,
                    height: 43.v,
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(5.h, 5.v, 5.h, 6.v),
                  ),
                ],
              ),
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  tf,
  x40,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
