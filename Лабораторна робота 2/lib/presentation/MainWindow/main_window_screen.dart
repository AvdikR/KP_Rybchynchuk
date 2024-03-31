
import 'package:flutter/material.dart';
import 'package:what_u_cread/core/app_export.dart';
import 'package:what_u_cread/presentation/BookInfoMenu/book_info_menu.dart';
import 'package:what_u_cread/presentation/MainWindow/widgets/main_window_widget.dart';

class MainWindow extends StatefulWidget{
  const MainWindow({Key? key}) : super(key: key);

  @override
  MainWindowState createState() =>
      MainWindowState();
}

class MainWindowState extends State<MainWindow>
  with AutomaticKeepAliveClientMixin<MainWindow>{

    @override
    bool get wantKeepAlive => true;

    @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Column(children: [
                    _buildBooksList(context)
                  ])
                ])))));
  }

  Widget _buildBooksList(BuildContext context){
    return Padding(
        padding: EdgeInsets.only(left: 20.h, right: 15.h),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 181.v,
                crossAxisCount: 2,
                mainAxisSpacing: 11.h,
                crossAxisSpacing: 11.h),
            physics: BouncingScrollPhysics(),
            itemCount: 8,
            itemBuilder: (context, index) {
              return MainWindowWidget(onTapContent: () {
                onTapBookContent(context);
              });
            }));
  }

  onTapBookContent(context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookInfoMenu()));
  }

}

