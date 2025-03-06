import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orbit_csm/ui/OpenTasks/OpenTasksState.dart';
import 'package:orbit_csm/ui/OpenTasks/OpenTasksViewModel.dart';
import 'package:orbit_csm/util/colors.dart';
import 'package:orbit_csm/util/dimensions.dart';
import 'package:provider/provider.dart';

class DashboardState extends StatefulWidget{
  const DashboardState({super.key});

  @override
  State<DashboardState> createState() => _DashboardState();

}

class _DashboardState extends State<DashboardState>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left:Dimensions.level4Margin(context)),
            child: Text(
              "Your Tasks",
              style: TextStyle(
                fontSize: Dimensions.largeTextSize(context),
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue, // Adjust color as needed
              ),
            ),
          ),
          SizedBox(height: Dimensions.level3Margin(context)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: Dimensions.level4Margin(context),left: Dimensions.level4Margin(context)),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: Dimensions.level3Margin(context),
                mainAxisSpacing: Dimensions.level3Margin(context),
                children: const [
                  DashboardCard(
                    title: 'Open Tasks',
                    back_img: 'assets/images/png/open_tasks.png',
                    color: AppColors.darkBlue,
                    logo: 'assets/images/png/ic_open.png'
                  ),
                  DashboardCard(
                    title: 'Close Tasks',
                    back_img: 'assets/images/png/close_tasks.png',
                    color: AppColors.darkRed,
                      logo: 'assets/images/png/ic_close.png'
                  ),
                  DashboardCard(
                    title: 'All Tasks',
                    back_img: 'assets/images/png/all_tasks.png',
                    color: AppColors.darkYellow,
                      logo: 'assets/images/png/ic_all.png'
                  ),
                  DashboardCard(
                    title: 'Group Tasks',
                    back_img: 'assets/images/png/group_tasks.png',
                    color: AppColors.darkGreen,
                      logo: 'assets/images/png/ic_group.png'
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String back_img;
  final Color color;
  final String logo;

  const DashboardCard({
    super.key,
    required this.title,
    required this.back_img,
    required this.color,
    required this.logo
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.utilizationTextSize(context)),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(back_img), // Replace with your background image
            fit: BoxFit.cover, // Adjust how the image fits
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (_) => OpenTasksViewModel(),
                  child: OpenTasksState(),
                ),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.largeTextSize(context)),
                    child: Image.asset(
                      logo,
                      width: Dimensions.level4Margin(context),
                      height: Dimensions.level4Margin(context),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(height: Dimensions.level5Margin(context)),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.largeTextSize(context)),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: Dimensions.largerTextSize(context),
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget _buildCustomAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(Dimensions.level5Size(context)), // Custom height
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: Dimensions.largerTextSize(context),top: Dimensions.level5Margin(context),right: Dimensions.largerTextSize(context),bottom: Dimensions.largerTextSize(context)),
        child: AppBar(
          automaticallyImplyLeading: false, // Remove default back button
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              // Custom Logo
              Image.asset(
                'assets/images/png/ic_customer.png', // Path to your PNG image
                width: Dimensions.iconSize(context),
                height: Dimensions.iconSize(context),
              ),
              SizedBox(width: Dimensions.utilizationTextSize(context)),
              // Name and Designation
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: Dimensions.mediumTextSize(context),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'ATEngineer',
                    style: TextStyle(
                      fontSize: Dimensions.smallTextSize(context),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            // Logout Button
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/png/ic_back_logout.png'), // Background image
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/png/ic_logout.png',
                      height: Dimensions.iconSize(context),
                      width: Dimensions.iconSize(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.largerTextSize(context)),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: Dimensions.mediumTextSize(context),
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}