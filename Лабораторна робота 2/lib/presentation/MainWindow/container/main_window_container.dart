
import 'package:flutter/material.dart';
import 'package:what_u_cread/core/app_export.dart';
import 'package:what_u_cread/presentation/MainWindow/main_window_screen.dart';
import 'package:what_u_cread/widgets/custom_floating_button.dart';

class MainWindowContainer extends StatefulWidget{
  const MainWindowContainer({Key? key})
      : super(
          key: key,  
        );
  @override
  MainWindowContainerState createState() =>
      MainWindowContainerState();
}

class MainWindowContainerState extends State<MainWindow> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late TabController tabviewController;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState(){
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            children: [
              _buildTabview(context),
              Expanded(
                child: SizedBox(
                  height: 631.v,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      MainWindow(),
                      MainWindow(),
                      MainWindow(),
                      MainWindow(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

   Widget _buildTabview(BuildContext context) {
    return SizedBox(
      height: 89.v,
      width: double.maxFinite,
      child: TabBar(
        controller: tabviewController,
        isScrollable: true,
        labelColor: appTheme.whiteA700,
        unselectedLabelColor: appTheme.whiteA700,
        tabs: [
          Tab(
            child: Text(
              " Book1",
            ),
          ),
          Tab(
            child: Text(
              "Book 2",
            ),
          ),
          Tab(
            child: Text(
              "Book 3",
            ),
          ),
          Tab(
            child: Text(
              "Book 4",
            ),
          ),
          Tab(
            child: Text(
              "Book 5",
            ),
          ),
          Tab(
            child: Text(
              "Book 6",
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
      height: 60,
      width: 60,
      backgroundColor: appTheme.blueGray100,
      child: CustomImageView(
        imagePath: ImageConstant.img2630511,
      ),
    );
  }



}
