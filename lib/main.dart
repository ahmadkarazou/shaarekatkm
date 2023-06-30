import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shaarekatkm/providers/Organtion.dart';
import 'package:shaarekatkm/providers/userData.dart';
import 'package:shaarekatkm/screens/home.dart';
import 'package:shaarekatkm/screens/input_Org.dart';
import 'package:shaarekatkm/screens/orgPage.dart';
import 'package:shaarekatkm/screens/parsonalPage.dart';

import 'providers/aoth.dart';
import 'screens/login.dart';
import 'screens/splash_screen.dart';
import 'screens/swetcheUserOrOrg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
// async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider.value(value: Auth()),
// ChangeNotifierProvider<UserData>(
//   create: (_) => UserData(),
// ),
// ChangeNotifierProvider<Organtions>(
//   create: (_) => Organtions(),
// ),
//     ],
//     child: const MyApp(),
//   ));
// }

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, UserDatas>(
            create: (_) => UserDatas(),
            update: (ctx, authValue, preciousProducts) => preciousProducts
            // ..getData(authValue.token, preciousProducts.userId,
            //     preciousProducts == null ? null : preciousProducts.items),
            ),
        ChangeNotifierProxyProvider<Auth, Organtions>(
            create: (_) => Organtions(),
            update: (ctx, authValue, preciousOrders) => preciousOrders),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? Home()
              // : FutureBuilder(
              //     future: auth.tryAutoLogin(),
              //     builder: (ctx, AsyncSnapshot authSnapshot) =>
              //         authSnapshot.connectionState == ConnectionState.waiting
              //             ? SplashScreen()
              : Login(),
          //),
          routes: {
            Home.routeName: (_) => const Home(),
            SwetchUOrO.routeName: (_) => SwetchUOrO(),
            // OrgPage.routeName: (_) => const OrgPage(),
            InpoutOrg.routeName: (_) => const InpoutOrg(),
            ParsonalPage.routeName: (_) => const ParsonalPage(),
          },
        ),
      ),
    );
    // MaterialApp(

    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     accentColor: Colors.deepOrange,
    //     fontFamily: 'Lato',
    //   ),
    //   home: const Login(),
    //   routes: {
    //     Login.routeName: (_) => const Login(),
    //     Home.routeName: (_) => const Home(),
    //     SwetchUOrO.routeName: (_) => SwetchUOrO(),
    //     OrgPage.routeName: (_) => const OrgPage(),
    //     InpoutOrg.routeName: (_) => const InpoutOrg(),
    //     ParsonalPage.routeName: (_) => const ParsonalPage(),
    //   },
    // );
  }
}
