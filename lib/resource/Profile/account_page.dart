import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:webspc/resource/Profile/spc_wallet_page.dart';
import 'package:webspc/resource/Profile/spot_screen.dart';
import 'package:webspc/resource/Profile/userinfor_page.dart';
import 'package:webspc/widget/sizer.dart';
import '../../DTO/cars.dart';
import '../../DTO/section.dart';
import '../../DTO/user.dart';
import 'package:intl/intl.dart';
import '../../widget/colors.dart';
import '../Home/circle_avatar.dart';
import '../Login&Register/login_page.dart';
import 'car_detail_screen.dart';
import 'car_register_screen.dart';
import 'family_screen.dart';
import 'family_share_car.dart';
import 'history_payment.dart';
import 'view_history.dart';
import '../../navigationbar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  AccountPageState createState() => AccountPageState();
}

class MenuTile {
  String? title;
  String? subtitle;
  IconData iconData;
  Function onTap;
  MenuTile(this.title, this.subtitle, this.iconData, this.onTap);
}

class AccountPageState extends State<AccountPage> {
  int selectedIndex = 1;
  int selectedCatIndex = 1;
  double wallet = Session.loggedInUser.wallet ?? 0;
  String formatCurrency(double n) {
    // Add comma to separate thousands
    var currency = NumberFormat("#,##0", "vi_VN");
    return currency.format(n);
  }

  Widget build(BuildContext context) {
    List<MenuTile> menu = [
      MenuTile('Your Information', 'Your Information', Icons.person_sharp, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserInforScreen()));
      }),
      MenuTile('Information Your Car', 'Information Your Car', Icons.car_crash,
          () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CarDetailScreen()));
      }),
      MenuTile(
          'Register Your Car', 'Register Your Car', Icons.car_rental_rounded,
          () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CarRegisterScreen()));
      }),
      MenuTile('Buy Spot', 'Buy Spot', Icons.call_to_action_rounded, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SpotScreen(context)));
      }),
      MenuTile('SPS Wallet', 'SPS Wallet', Icons.wallet, () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SPCWalletScreen(context),
          ),
        ).then((_) {
          setState(() {
            wallet = Session.loggedInUser.wallet ?? 0;
          });
        });
      }),
      MenuTile('Family', 'Family', Icons.family_restroom, () {
        Navigator.pushNamed(context, FamilyScreen.routerName);
      }),
      MenuTile(
          'Share Car with Family', 'Share Car with Family', Icons.share_sharp,
          () {
        Navigator.pushNamed(context, ShareCarFamilyScreen.routerName);
      }),
      //
      MenuTile('History', 'History', Icons.history, () {
        Navigator.pushNamed(context, ViewUserHistoryPage.routeName);
      }),
      MenuTile('History Payment', 'History Payment', Icons.payment, () {
        Navigator.pushNamed(context, ViewHistoryPaymentPage.routeName);
      }),
      MenuTile('Logout', 'Logout', Icons.exit_to_app, () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Do you want to logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Session.loggedInUser = Users(userId: "0");
                  Session.carUserInfor = Car();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen(context)),
                    (route) => false,
                  );
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      }),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bga1png.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.sp,
              ),
              FadedScaleAnimation(
                scaleDuration: const Duration(milliseconds: 400),
                fadeDuration: const Duration(milliseconds: 400),
                child: AppCircleAvatar(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUvePhR35ttTv3wCi3ZY6q7PWOpacQ9JYWciXvTYS6EC-7fp70t5eOCl9wyd20LddfZkA&usqp=CAU',
                  size: 120.sp,
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                      width: 2.0, color: Color.fromARGB(100, 161, 125, 17)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadedScaleAnimation(
                      scaleDuration: const Duration(milliseconds: 400),
                      fadeDuration: const Duration(milliseconds: 400),
                      child: Text(
                        'Balance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadedScaleAnimation(
                      scaleDuration: const Duration(milliseconds: 400),
                      fadeDuration: const Duration(milliseconds: 400),
                      child: Text(
                        formatCurrency(wallet) + ' VND',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Container(
                color: Colors.transparent,
                child: GridView.builder(
                    itemCount: menu.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.6,
                            crossAxisCount: 2,
                            mainAxisExtent: 102),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: menu[index].onTap as void Function()?,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 6),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: kButtonBorderColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadedScaleAnimation(
                                scaleDuration:
                                    const Duration(milliseconds: 400),
                                fadeDuration: const Duration(milliseconds: 400),
                                child: Text(
                                  menu[index].title!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      menu[index].subtitle!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontSize: 12,
                                              color: lightGreyColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(
                                    menu[index].iconData,
                                    size: 30.sp,
                                    color: kContainerTextColor.withOpacity(0.8),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(selectedCatIndex, context),
    );
  }
}
