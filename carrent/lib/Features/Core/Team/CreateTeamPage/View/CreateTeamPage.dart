import 'package:carrent/Features/Core/Team/CreateTeamPage/Widget/CreateTeamPageBody.dart';
import 'package:carrent/Features/Core/Team/CreateTeamPage/cubit/create_team_cubit.dart';
import 'package:carrent/GeneralWidgets/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTeamPage extends StatelessWidget {
  const CreateTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText("Create Your Team"),
      ),
      body: BlocProvider(
        create: (context) => CreateTeamCubit(),
        child: const CreateTeamBody(),
      ),
    );
  }
}
