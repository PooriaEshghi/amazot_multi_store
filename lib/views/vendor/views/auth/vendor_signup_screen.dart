import 'package:amazot_multi_store/controllers/vendor_auth_controller.dart';
import 'package:amazot_multi_store/utils/show_snackBar.dart';
import 'package:amazot_multi_store/views/buyers/auth/login_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/auth/vendor_register_screen.dart';
import 'package:flutter/material.dart';

class VendorSignUp extends StatefulWidget {
  @override
  State<VendorSignUp> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<VendorSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  late String email;

  late String password;
  late String confirmPassword;

  bool _isLoading = false;

  _signUpVendor() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController
          .signUpVendors(email, password, confirmPassword)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });
      return showSnack(context, 'Account has been created for you');
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Fields must not be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Customer"s Account',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(labelText: 'Enter Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(labelText: 'Enter Password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone Number must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    decoration:
                        InputDecoration(labelText: 'Enter Phone Number'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _signUpVendor();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return VendorRegisterScreen();
                      }),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade900,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4),
                            ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have An Account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }),
                          );
                        },
                        child: Text('Login'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:safety_plan/common/theme/pain_coach_theme.dart';
// import 'package:safety_plan/common/utilities/dialog_utilities.dart';
// import 'package:safety_plan/router/pain_coach_router.dart';

// import '../../common/constants.dart';
// import '../../common/utilities/safety_plan_link_manager.dart';
// import '../../common/widgets/pain_coach_navbar.dart';

// class SupportStep1 extends ConsumerStatefulWidget {
//   const SupportStep1({super.key});

//   @override
//   ConsumerState<SupportStep1> createState() => _SupportStep1State();
// }

// class _SupportStep1State extends ConsumerState<SupportStep1> {
//   final DialogUtilities dialogUtilities = DialogUtilities();
  // final List<String> _categorylable = [
  //   'Pacing',
  //   'Mindfulness',
  //   'Relaxation',
  //   'Thoughts and Feelings',
  // ];
  // @override
  // void initState() {
  //   //_loadContents();
  //   super.initState();
  // }

  // Future<void> _loadContents() async {
  //   try {
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   } catch (e, stack) {
  //     debugPrint(e.toString());
  //     debugPrint(stack.toString());
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //       systemOverlayStyle: PainCoachAppTheme.of(context).systemUiOverlayStyle,
  //       automaticallyImplyLeading: false,
  //     ),

  //     //body: SingleChildScrollView(
  //     body: Padding(
  //       padding: const EdgeInsets.all(9.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Tools',
  //             style: TextStyle(fontSize: 19),
  //           ),
  //           Container(
  //             height: 1200,
  //             child: ListView.builder(
  //                 itemCount: _categorylable.length,
  //                 itemBuilder: (context, index) {
  //                   return Padding(
  //                     padding: const EdgeInsets.all(10.0),
  //                     child: Container(
  //                       width: MediaQuery.of(context).size.width,
  //                       height: 100,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(14),
  //                         color: const Color(0xFFDEE6ED),
  //                       ),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Image.asset('assets/images/2x/vertical_logo.png'),
  //                           Text(
  //                             _categorylable[index],
  //                             style: TextStyle(
  //                                 color: Constants.textParagraphColor,
  //                                 fontSize: 18,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                           IconButton(
  //                               onPressed: () {
  //                                 print('On Pressed');
  //                               },
  //                               icon: Icon(Icons.arrow_forward_ios))
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 }),
  //           ),
  //         ],
  //       ),
  //     ),
  //     bottomNavigationBar: PainCoachNavBar(
  //       selectedIndex: 2,
  //     ),
  //   );
  // }

//   void _onVeteranCrisisLineTap() {
//     PainCoachLinkManager.callTelephoneNumber("1-800-273-8255");
//   }

//   void _onCrisisTextLineTap() {
//     PainCoachLinkManager.openLink(context,
//         link: "https://www.crisistextline.org");
//   }

//   void _onNextButtonTap() {
//     context.push(PainCoachRouter.checkinStep2);
//   }

//   void _onCloseButtonTap(BuildContext context) {
//     dialogUtilities.showConfirmDialog(
//         context, null, null, null, _onDialogConfirmed);
//   }

//   void _onDialogConfirmed(Object? provider, String? itemId) {
//     context.push(PainCoachRouter.home);
//   }
// }
