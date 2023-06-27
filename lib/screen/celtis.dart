// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usdcode/cubit/app_cubit.dart';
import 'package:usdcode/cubit/app_cubit_state.dart';

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
