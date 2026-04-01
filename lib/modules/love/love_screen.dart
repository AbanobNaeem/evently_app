import 'package:flutter/material.dart';

import '../../shared/component/card/event_card.dart';

class LoveScreen extends StatelessWidget {
  const LoveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Expanded(child: ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder:(context, index) =>  EventCard(),
          separatorBuilder:(context, index) => SizedBox(height: size.height * 0.01,),
          itemCount: 20)),
    );
  }
}
