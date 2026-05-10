import 'package:flutter/material.dart';

import '../../../../core/entities/app_color.dart';

class CardList extends StatelessWidget {
  CardList({
    super.key,
    required this.cardColor,
    required this.titleList,
    required this.index,
  });

  List<Map<String, dynamic>> titleList;
  List<Color> cardColor;

  final int index;
  final List<Color> iconColor = [
    AppColor.locationIconColor,
    AppColor.educationIconColor,
    AppColor.skillIconColor,
  ];
  final List<IconData> icon = [
    Icons.location_on_outlined,
    Icons.school_outlined,
    Icons.code_off_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: .circular(15)),
        elevation: 2,
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: .circular(15)),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor[index % iconColor.length],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon[index % icon.length], color: Colors.white),
          ),
          tileColor: cardColor[index % cardColor.length],
          subtitle: Text(
            titleList[index]['subtitle'],
            style: TextStyle(color: Colors.black),
          ),
          title: Text(
            titleList[index]['title'],
            style: TextStyle(fontWeight: .bold),
          ),
        ),
      ),
    );
  }
}
