import 'package:fireapp3/core/constants/color_const.dart';
import 'package:fireapp3/core/constants/font_const.dart';
import 'package:fireapp3/core/widgets/appbar_wirget.dart';
import 'package:fireapp3/screens/home/home_page.dart';
import 'package:fireapp3/screens/pages/card_page.dart';
import 'package:fireapp3/screens/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Cat Coffee",
        centerTitle: true,
        context: context,
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        height: MediaQuery.of(context).size.height * 1,
        color: Colors.white38,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(FontConst.kExtraSmallFont),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: ColorConst.kPrimaryWhite,
                  radius: FontConst.kMediumLargeFont,
                  child: Icon(
                    Icons.person,
                    color: ColorConst.kPrimaryBlack,
                    size: FontConst.kBigFont,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Check email",
                      style: TextStyle(
                        color: ColorConst.kPrimaryWhite,
                        fontSize: FontConst.kSmallFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.mark_email_unread,
                        color: ColorConst.kPrimaryWhite,
                      ),
                      onPressed: () async {
                        debugPrint(auth.currentUser!.emailVerified.toString());
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delete account",
                      style: TextStyle(
                        color: ColorConst.kPrimaryWhite,
                        fontSize: FontConst.kSmallFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: ColorConst.kPrimaryWhite,
                      ),
                      onPressed: () {
                        deleteAccount(context);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Log Out",
                      style: TextStyle(
                        color: ColorConst.kPrimaryWhite,
                        fontSize: FontConst.kSmallFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.logout_outlined,
                        color: ColorConst.kPrimaryWhite,
                      ),
                      onPressed: signOut,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [HomePage(), CardPage()],
      ),
      bottomNavigationBar: TabBar(
        controller: tabController,
        labelColor: ColorConst.kPrimaryWhite,
        unselectedLabelColor: Colors.brown.shade200,
        indicatorColor: ColorConst.kPrimaryWhite,
        tabs: const [
          Tab(
            icon: Icon(Icons.home),
            text: "Home",
          ),
          Tab(
            icon: Icon(Icons.shopping_cart),
            text: "Basket",
          ),
        ],
      ),
    );
  }

  Future signOut() async {
    await auth.signOut();
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

  showMySnackbar(String content, Color color, context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: color,
      ),
    );
  }
}
