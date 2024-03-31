// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:what_u_cread/core/app_export.dart';
import 'package:what_u_cread/widgets/app_bar/appbar_trailing_image.dart';
import 'package:what_u_cread/widgets/app_bar/custom_app_bar.dart';
import 'widgets/user_interface_widget.dart';

class UserInterface extends StatelessWidget {
  UserInterface({Key? key}) : super(key: key);

  int allBooks = favoriteBooks + readingBooks;
  static int favoriteBooks = 0;
  static int readingBooks = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 24.v),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    onTapUserSettings(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.v),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgUserIcon,
                          height: 80.adaptSize,
                          width: 80.adaptSize,
                          radius: BorderRadius.circular(40.h),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.h,
                            top: 34.v,
                            bottom: 4.v,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Guest001',
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                              SizedBox(height: 8.v),
                              Text(
                                "ID: 70894126",
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 26.v),
              _buildCountsRow(context),
              SizedBox(height: 26.v),
              _buildMenuRow(context),
              SizedBox(height: 26.v),
              _buildReadingBookList(context),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context){
    return CustomAppBar(actions: [
      AppbarTrailingImage(
        imagePath: ImageConstant.imageNotFound,
        margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v))
    ]);
  }

  Widget _buildCountsRow(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(children: [
          Text("All Books", style: CustomTextStyles.bodyMedium14),
          SizedBox(height: 10.v),
          Text('$allBooks', style: CustomTextStyles.bodyLargeBlack900)
        ]),
        _buildBooksColumn(context,
            booksText: "Reading books", zipcodeText: '$readingBooks'),
        _buildBooksColumn(context,
            booksText: "Favorite books", zipcodeText: "$favoriteBooks")
      ]));
  }

  Widget _buildMenuRow(BuildContext context) {
    return Container(    
        width: double.maxFinite,   
        padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 16.v),  
        decoration: AppDecoration.fillGray,     
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [         
          CustomImageView(    
              imagePath: ImageConstant.imgFavoriteBook,         
              height: 40.adaptSize,        
              width: 40.adaptSize),      
          CustomImageView(         
              imagePath: ImageConstant.imgReadingBook,          
              height: 40.adaptSize,        
              width: 40.adaptSize),      
          CustomImageView(        
              imagePath: ImageConstant.imgStatistics,         
              height: 40.adaptSize,      
              width: 40.adaptSize),         
        ]));  
  }


  Widget _buildReadingBookList(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index){
          return SizedBox(height: 16.v);
        }, 
        itemCount: 3,
        itemBuilder: (context, index){
          return const ReadingBooklistWidget();
        }));
  }


  Widget _buildBooksColumn(
    BuildContext context, {
      required String booksText,
      required String zipcodeText,
  }) {
    return Column(children: [
      Text(booksText,
          style: CustomTextStyles.bodyLargeBlack90018.copyWith(color: appTheme.gray500)),
      SizedBox(height: 10.v),
      Text(zipcodeText,
          style: CustomTextStyles.bodyLargeBlack900.copyWith(color: appTheme.blueGray400))
    ]);
  }


  onTapUserSettings(BuildContext context){

  }


}



