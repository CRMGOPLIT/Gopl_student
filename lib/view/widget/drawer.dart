import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_student/utils/color.dart';

import '../../utils/routes/routes_name.dart';

class drawer extends StatelessWidget {
  const drawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageurl =
        "https://cdn.siasat.com/wp-content/uploads/2021/05/tiger-shroff.jpg";
    return Container(
      width: 250.w,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), bottomRight: Radius.circular(50.r)),
        child: Drawer(
          // shape: borders,
          //backgroundColor: AppColors.PrimaryWhiteColor,
          child: ListView(
            //  clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.all(0.0),
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('Oflutter.com'),
                accountEmail: Text('example@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: AppColors.PrimaryMainColor,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://insidemusicschools.com/wp-content/uploads/2020/03/pexels-pixabay-267885-scaled.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(
                  CupertinoIcons.home,
                  color: Colors.black,
                ),
                title: Text(
                  "Home",
                  textScaleFactor: 1.0,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const ListTile(
                leading: Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.black,
                ),
                title: Text(
                  "Profile",
                  textScaleFactor: 1.0,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.aboutpage);
                },
                child: const ListTile(
                  leading: Icon(
                    CupertinoIcons.textformat_abc_dottedunderline,
                    color: Colors.black,
                  ),
                  title: Text(
                    "About Us",
                    textScaleFactor: 1.0,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  CupertinoIcons.arrow_down_circle,
                  color: Colors.black,
                ),
                title: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    "LOG OUT",
                    textScaleFactor: 1.0,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
