import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shaarekatkm/screens/TermsOfUse.dart';
import 'package:shaarekatkm/screens/UsagePolicies.dart';
import 'package:shaarekatkm/screens/definition.dart';
import 'package:shaarekatkm/screens/home.dart';
import 'package:shaarekatkm/screens/parsonalPage.dart';

import '../providers/aoth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('الوصول للمعلومات'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home_outlined, size: 30),
            title: const Text('الصفحة الرئيسة', style: TextStyle(fontSize: 20)),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Home.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.perm_identity, size: 30),
            title: const Text('الصفحة الشخصية', style: TextStyle(fontSize: 20)),
            onTap: () =>
                Navigator.of(context).pushNamed(ParsonalPage.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_balance_outlined, size: 30),
            title: const Text('عن شركاتكوم', style: TextStyle(fontSize: 20)),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Definition())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock_outline, size: 30),
            title: const Text('سياسة الخصوصية', style: TextStyle(fontSize: 20)),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UsagePolicies())),
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.playlist_add_check, size: 30),
              title:
                  const Text('شروط الاستخدام', style: TextStyle(fontSize: 20)),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => TermsOfUse()))),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, size: 30),
            title: const Text('تسجيل الخروج', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }
}
