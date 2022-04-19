import 'package:fireapp3/core/components/my_text_style_comp.dart';
import 'package:fireapp3/core/constants/color_const.dart';
import 'package:fireapp3/core/constants/font_const.dart';
import 'package:fireapp3/core/widgets/appbar_wirget.dart';
import 'package:fireapp3/provider/login_provider.dart';
import 'package:fireapp3/provider/upload_coffee_provider.dart';
import 'package:fireapp3/screens/home/home_admin_page.dart';
import 'package:fireapp3/screens/pages/card_admin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class DetailsAdminPage extends StatefulWidget {
  const DetailsAdminPage({Key? key}) : super(key: key);

  @override
  State<DetailsAdminPage> createState() => _DetailsAdminPageState();
}

class _DetailsAdminPageState extends State<DetailsAdminPage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TabController? tabController;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  XFile? image;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Cat Coffee Admin Panel",
        centerTitle: true,
        context: context,
        action: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: ColorConst.kPrimaryWhite,
              ),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: ColorConst.kPrimaryTransparent,
                  context: context,
                  builder: (_) {
                    return StatefulBuilder(
                      builder: (context, setState) => Card(
                        shape: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add new coffee",
                                style: MyTextStyleComp.showModalTextStyle,
                              ),
                              TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  helperStyle:
                                      MyTextStyleComp.showModalTextStyle,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: ColorConst.kPrimaryBlack,
                                    ),
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: priceController,
                                decoration: InputDecoration(
                                  hintText: 'Price',
                                  helperStyle:
                                      MyTextStyleComp.showModalTextStyle,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: ColorConst.kPrimaryBlack,
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  image = await _picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  context
                                      .read<UploadCoffeeProvider>()
                                      .uploadImageToStorage(
                                        image!,
                                        nameController.text,
                                      );
                                  debugPrint("!!!!!!!!!!1!!!!!");
                                  setState(() {});
                                },
                                child: const Text("Enter Image from gallary"),
                              ),
                              image != null
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: Image.file(
                                        File(
                                          image!.path,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const CircularProgressIndicator.adaptive(),
                              ElevatedButton(
                                child: const Text("Add a coffee to shop"),
                                onPressed: () {
                                  context
                                      .read<UploadCoffeeProvider>()
                                      .uploadToDB(
                                        nameController.text,
                                        priceController.text,
                                        context,
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        height: MediaQuery.of(context).size.height * 1,
        color: ColorConst.scaffoldBackground,
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
                    color: ColorConst.scaffoldBackground,
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
                        context.read<LoginProvider>().deleteAccount(context);
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
                      onPressed: () {
                        context.read<LoginProvider>().signOut(context);
                      },
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
        children: const [
          HomeAdminPage(),
          CardAdminPage(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: tabController,
        labelColor: ColorConst.scaffoldBackground,
        unselectedLabelColor: Colors.brown.shade300,
        indicatorColor: ColorConst.scaffoldBackground,
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
}
