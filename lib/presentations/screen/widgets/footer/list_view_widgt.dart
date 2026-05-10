import 'package:flutter/material.dart';

import 'card_widget.dart';

class ListviewWidget extends StatelessWidget {
  const ListviewWidget({
    super.key,
    required this.titleList,
    required this.cardColor,
  });

  final List<Map<String, dynamic>> titleList;
  final List<Color> cardColor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: titleList.length,
      itemBuilder: (context, index) {
        return CardList(
          cardColor: cardColor,
          titleList: titleList,
          index: index,
        );
      },
    );
  }
}
