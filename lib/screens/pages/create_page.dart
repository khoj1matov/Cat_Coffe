import 'package:fireapp3/core/constants/color_const.dart';
import 'package:fireapp3/core/constants/font_const.dart';
import 'package:fireapp3/core/widgets/appbar_wirget.dart';
import 'package:fireapp3/provider/login_provider.dart';
import 'package:fireapp3/screens/home/details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen(
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
        title: 'Cat Coffee Create Account',
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
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(FontConst.kMediumFont),
                ),
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(FontConst.kMediumFont),
                ),
                labelText: 'Password',
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
              child: const Text("Create"),
              onPressed: () {
                context.read<LoginProvider>().signUp(context);
              },
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
