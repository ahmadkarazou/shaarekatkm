import 'package:flutter/material.dart';

class UsagePolicies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'سياسة الخصوصية',
          style: TextStyle(fontSize: 25, color: Colors.black),
          textAlign: TextAlign.right,
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        color: Colors.blue.shade100,
        child: ListView(
          children: const [
            Text(
              'شركاتكوم خدمة تزيد من ثقة اعمالك التجارية امام عملائك',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              'الخدمة تسهل لك الوصول للعملاءالمستهدفين',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              'تقييم عملائك في صفحتك بخدمة شركاتكوم سيوضح جودة خدماتك أمام الجميع',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              'الخدمة مجانية وكل ما عليك هو التسجيل',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              'يمكنك الاشتراك في شركاتكوم خلال ثوان معدودة',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              'بإمكانك ربط جميع حساباتك في مختلف المنصات الاجتماعية في صفحتك بموقع شركاتكوم',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              'الخدمة سهلة ومفيدة، وسرية بياناتك مضمونة',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              'الخدمة تمنحك فرصة تسويق متجرك الإلكتروني في منصات شركاتكوم المختلفة',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              'بإمكانك الحصول على معلومات مهمة عن المتاجر الإلكترونية المسجلة في شركاتكوم',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              'بإمكانك الاطلاع على تقييم العملاء السابقين للمتاجر الإلكترونية',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
            Text(
              'بإمكانك الاطلاع على تقييم العملاء السابقين للمتاجر الإلكترونية',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
