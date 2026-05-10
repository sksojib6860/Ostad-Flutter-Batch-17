import 'package:flutter/material.dart';
import 'package:view_profile_ui/core/entities/app_color.dart';
import 'package:view_profile_ui/presentations/screen/widgets/footer/connect_me_text.dart';
import 'package:view_profile_ui/presentations/screen/widgets/footer/footer_widget.dart';
import 'package:view_profile_ui/presentations/screen/widgets/footer/list_view_widgt.dart';
import 'package:view_profile_ui/presentations/screen/widgets/header/bio_data.dart';
import 'package:view_profile_ui/presentations/screen/widgets/header/circle_avatar_widget.dart';
import 'package:view_profile_ui/presentations/screen/widgets/header/name_widget.dart';
import 'package:view_profile_ui/presentations/screen/widgets/header/title_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> titleList = [
      {'title': 'Location', 'subtitle': 'Dhaka, Bangladesh'},
      {'title': 'Education', 'subtitle': 'BSc In CSE '},
      {
        'title': 'Skills',
        'subtitle':
            'Flutter, Dart, Firebase, Github,\nREST APi,Provider & Bloc',
      },
    ];
    List<Color> cardColor = [
      Color(0xFFF2EBFA),
      Color(0xFFEBF5ED),
      Color(0xFFE8F0FC),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: Center(
          child: Text(
            'My Profile',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
      body: Container(
        color: AppColor.bodyColors,
        child: SingleChildScrollView(
          child: Column(
            spacing: 5,
            children: [
              SizedBox(height: 5),
              // Profile Image
              CircleAvatarWidget(),
              // Name
              NameWidget(),
              // Title/Role
              TitleWidget(),
              // Bio
              BioDataWidget(),
              //body design
              ListviewWidget(titleList: titleList, cardColor: cardColor),
              //Footer Design
              ConnectMeText(),
              SizedBox(height: 5),
              BottomWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
