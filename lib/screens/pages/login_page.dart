import 'package:fireapp3/core/components/my_text_style_comp.dart';
import 'package:fireapp3/core/constants/color_const.dart';
import 'package:fireapp3/core/constants/font_const.dart';
import 'package:fireapp3/core/widgets/appbar_wirget.dart';
import 'package:fireapp3/provider/login_provider.dart';
import 'package:fireapp3/service/firebase_servoce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    FireService.auth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          debugPrint("User is currently signed out!");
        } else {
          debugPrint("User is signed in");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Cat Coffee Login',
        context: context,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(FontConst.kExtraLargFont),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Lottie.asset('assets/lottie/lazydoge.json'),
            ),
            Form(
              key: context.watch<LoginProvider>().fromKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: context.watch<LoginProvider>().emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(FontConst.kMediumFont),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller:
                        context.watch<LoginProvider>().passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(FontConst.kMediumFont),
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(170, 50),
                primary: ColorConst.scaffoldBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(FontConst.kLargeFont),
                ),
              ),
              child: const Text("Log in"),
              onPressed: () {
                context.read<LoginProvider>().signIn(context);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      primary: ColorConst.scaffoldBackground),
                  onPressed: () {
                    context.read<LoginProvider>().forgotPassword(context);
                  },
                  child: Text(
                    "Forgot password?",
                    style: MyTextStyleComp.loginForgotAndCreateTextStyle,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      primary: ColorConst.scaffoldBackground),
                  onPressed: () {
                    Navigator.pushNamed(context, '/create');
                  },
                  child: Text(
                    "Create account?",
                    style: MyTextStyleComp.loginForgotAndCreateTextStyle,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 30),
                        primary: ColorConst.scaffoldBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(FontConst.kLargeFont),
                        ),
                      ),
                      child: const Text("Google"),
                      onPressed: () {
                        context.read<LoginProvider>().signInWithGoogle(context);
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 30),
                    primary: ColorConst.scaffoldBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(FontConst.kLargeFont),
                    ),
                  ),
                  child: const Text("Facebook"),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
