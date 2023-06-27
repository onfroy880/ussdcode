// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:usdcode/cubit/app_cubit.dart';
import 'package:usdcode/cubit/app_cubit_state.dart';

class MtnScreen extends StatefulWidget {
  const MtnScreen({super.key});

  @override
  State<MtnScreen> createState() => _MtnScreenState();
}

class _MtnScreenState extends State<MtnScreen> {
  List<dynamic> optionsCode = [
    {"libelle": "Service Client", "code": "8787"},
    {"libelle": "Messagerie vocale", "code": "111"},
    {"libelle": "Connaitre son numéro de téléphone", "code": "*135*8#"},
    {"libelle": "Portail d’accès aux services", "code": " 	*123# "},
    {"libelle": "Check the main balance", "code": " *155# "},
    {"libelle": "Consultation du crédit bonus", "code": "*159*2#"},
    {"libelle": "Consultation du solde internet", "code": "*147*9#"},
    {"libelle": "Souscrire à un pack SMS", "code": "*148#"},
    {"libelle": "Mobile Money", "code": "*880#"},
    {"libelle": "Voicemail", "code": "101"},
    {"libelle": "Verifier Solde Mobile Money", "code": "*880*4#"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, CubitState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: optionsCode.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  String usdCode = optionsCode[index]['code'].toString();
                  try {
                    bool? call =
                        await FlutterPhoneDirectCaller.callNumber(usdCode);
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
          );
        },
      ),
    );
  }
}
