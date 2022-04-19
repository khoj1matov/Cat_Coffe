import 'package:fireapp3/core/constants/color_const.dart';
import 'package:fireapp3/screens/pages/login_page.dart';
import 'package:fireapp3/service/firebase_servoce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  Future signUp(BuildContext context) async {
    debugPrint("kirdi1");
    try {
      UserCredential user =
          await FireService.auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      debugPrint("kirdi2");

      showMySnackbar(
          "Success:" + user.user!.email.toString(), Colors.green, context);
      await FireService.auth.currentUser!.sendEmailVerification();
      if (emailController.text == 'admin@gmail.com' &&
          passwordController.text == '332211') {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/admin',
          (route) => false,
        );
        debugPrint("kirdi3");
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/details',
          (route) => false,
        );
        debugPrint("kirdi4");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        showMySnackbar("The password provided is too weak.",
            ColorConst.kPrimaryRed, context);
      } else if (e.code == "email-already-in-use") {
        showMySnackbar("The account already exists for that email.",
            ColorConst.kPrimaryRed, context);
      }
    } catch (e) {
      showMySnackbar(
          "There is such kind of error.", ColorConst.kPrimaryRed, context);
    }
  }

  Future signIn(BuildContext context) async {
    try {
      UserCredential user = await FireService.auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (emailController.text == 'admin@gmail.com' &&
          passwordController.text == '332211') {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/admin',
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/details',
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showMySnackbar(
            "No user found for that email.", ColorConst.kPrimaryRed, context);
      } else if (e.code == "wrong-password") {
        showMySnackbar("Wrong password provided for that user.",
            ColorConst.kPrimaryRed, context);
      }
    }
  }

  Future forgotPassword(BuildContext context) async {
    await FireService.auth.sendPasswordResetEmail(email: emailController.text);
    showMySnackbar(
        "Passwword reset link is send to email !", Colors.orange, context);
  }

  Future signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/details',
        (route) => false,
      );
    } catch (e) {
      showMySnackbar("Error Google Sign In", ColorConst.kPrimaryRed, context);
    }
  }

  Future signOut(BuildContext context) async {
    await FireService.auth.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
  }

  Future deleteAccount(context) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        showMySnackbar("Delete your account", ColorConst.kPrimaryRed, context);
      }
    }
  }

  showMySnackbar(String content, Color color, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: color,
      ),
    );
  }
}
