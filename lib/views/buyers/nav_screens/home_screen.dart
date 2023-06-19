import 'package:amazot_multi_store/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:amazot_multi_store/views/buyers/nav_screens/widgets/category_text_widget.dart';
import 'package:amazot_multi_store/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:amazot_multi_store/views/buyers/nav_screens/widgets/welcome_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../controllers/google_auth_controller.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

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
        CatergoryText(),
        ElevatedButton(
          onPressed: () async {
            await _authService.signOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }),
            );
          },
          child: Text('Sign Out'),
        ),
      ],
    );
  }
}
