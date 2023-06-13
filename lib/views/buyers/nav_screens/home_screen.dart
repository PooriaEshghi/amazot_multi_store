import 'package:amazot_multi_store/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:amazot_multi_store/views/buyers/nav_screens/widgets/category_text_widget.dart';
import 'package:amazot_multi_store/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:amazot_multi_store/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:amazot_multi_store/views/buyers/nav_screens/widgets/welcome_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WelcomeText(),
        SizedBox(
          height: 19,
        ),
        SearchInputWidget(),
        BannerWidget(),
        CatergoryText()
      ],
    );
  }
}
