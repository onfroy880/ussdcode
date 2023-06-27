import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usdcode/cubit/app_cubit.dart';
import 'package:usdcode/cubit/app_cubit_state.dart';
import 'package:usdcode/screen/celtis.dart';
import 'package:usdcode/screen/moov.dart';
import 'package:usdcode/screen/mtn.dart';

class AppCubitLogic extends StatefulWidget {
  const AppCubitLogic({super.key});

  @override
  State<AppCubitLogic> createState() => _AppCubitLogicState();
}

class _AppCubitLogicState extends State<AppCubitLogic> {

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
              child: Center(
                child: Text('Operateurs'),
              ),
            ),
            ListTile(
              title: const Text('MTN'),
              onTap: () {
                BlocProvider.of<AppCubit>(context).changeState(1);
              },
            ),
            ListTile(
              title: const Text('MOOV'),
              onTap: () {
                BlocProvider.of<AppCubit>(context).changeState(2);
              },
            ),
            ListTile(
              title: const Text('CELTIS'),
              onTap: () {
                BlocProvider.of<AppCubit>(context).changeState(3);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('USSD CODE'),
      ),
      body: BlocBuilder<AppCubit, CubitState>(
        builder: (context, state) {
          if (state is MtnState) {
            return const MtnScreen();
          } else if (state is MoovState) {
            return const MoovScreen();
          } else if (state is CeltisState) {
            return const CeltisScreen();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
