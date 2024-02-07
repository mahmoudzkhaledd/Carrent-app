import 'package:carrent/Features/Core/Packages/AllPackages/View/widgets/AllPackagesBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../GeneralWidgets/AppText.dart';
import '../bloc/all_packages_cubit.dart';

class AllPackagesPage extends StatelessWidget {
  const AllPackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('Packages'),
        
      ),
      body: BlocProvider(
        create: (c) => AllPackagesCubit(),
        child: const AllPackagesBody(),
      ),
    );
  }
}
