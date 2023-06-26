import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usdcode/screen/celtis.dart';
import 'package:usdcode/screen/mtn.dart';

class MoovScreen extends StatefulWidget {
  const MoovScreen({super.key});

  @override
  State<MoovScreen> createState() => _MoovScreenState();
}

class _MoovScreenState extends State<MoovScreen> {
  List<dynamic> optionsCode = [
    {"libelle": "Offres internet", "code": "*123#"},
    {"libelle": "Forfaits voix et Pass Bonus", "code": "*173#"},
    {"libelle": "Consultation de solde", "code": "*104*5#"},
    {"libelle": "Portail des offres et services", "code": "*199#"},
    {"libelle": "Moov Money", "code": "*855#"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Operateurs'),
            ),
            ListTile(
              title: const Text('MTN'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MtnScreen()),
                    (route) => false);
              },
            ),
            ListTile(
              title: const Text('MOOV'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('CELTIS'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CeltisScreen()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('MOOV Usd Code'),
      ),
      body: ListView.builder(
        itemCount: optionsCode.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              String usdCode = optionsCode[index]['code'].toString();
              try {
                print(usdCode);
                bool? call = await FlutterPhoneDirectCaller.callNumber(usdCode);
              } catch (e) {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: usdCode,
                );
                await launch(launchUri.toString());
              }
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.black26,
              child: Center(
                child: Text(optionsCode[index]['libelle']),
              ),
            ),
          );
        },
      ),
    );
  }
}
