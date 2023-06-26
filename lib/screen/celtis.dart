import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usdcode/screen/moov.dart';
import 'package:usdcode/screen/mtn.dart';

class CeltisScreen extends StatefulWidget {
  const CeltisScreen({super.key});

  @override
  State<CeltisScreen> createState() => _CeltisScreenState();
}

class _CeltisScreenState extends State<CeltisScreen> {
  List<dynamic> optionsCode = [
    {"libelle": "Assistance client", "code": "7373"},
    {"libelle": "Suivi consommation", "code": "*104#"},
    {"libelle": "Activation Top Appel", "code": "*199#"}
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
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MoovScreen()),
                    (route) => false);
              },
            ),
            ListTile(
              title: const Text('CELTIS'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('CELTIS Usd Code'),
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
