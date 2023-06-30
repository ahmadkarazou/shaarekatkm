import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shaarekatkm/screens/VisitorData.dart';

import '../providers/userData.dart';



class SwetchUOrO extends StatelessWidget {
  static const routeName= '/SwetcheUsre';
bool userOrg;
  @override
  Widget build(BuildContext context) {
     //var userP =Provider.of<UserDatas>(context,listen: false).setIsCombane(userOrg);
      
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اختيار الحساب',
          style: TextStyle(fontSize: 25, color: Colors.black),
          textAlign: TextAlign.right,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        margin:const EdgeInsets.all(15),
        //color: Colors.amberAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                userOrg=true;
                 Provider.of<UserDatas>(context,listen: false).setIsCombane(userOrg);
                  print(userOrg);
                 Navigator.of(context).push(MaterialPageRoute(builder: (context){return VisitorData();}));
                 
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'حساب تاجر',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  Text(
                    'كتاجر سوف تتمكن من اضافة عملك',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 150),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
           const SizedBox(height: 20),
            ElevatedButton(
             onPressed: () {

                userOrg=false;
                Provider.of<UserDatas>(context,listen: false).setIsCombane(userOrg);
                print(userOrg);
                 Navigator.of(context).push(MaterialPageRoute(builder: (context){return VisitorData();}));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'حساب زائر',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  Text(
                    '''كزائر ستتمكن من تصفح المتاجرالمسجلة بالمنصة وتقيمها والتعليق عليها''',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 150),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 25),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              child: const Text(
                'تسجيل دخول',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
