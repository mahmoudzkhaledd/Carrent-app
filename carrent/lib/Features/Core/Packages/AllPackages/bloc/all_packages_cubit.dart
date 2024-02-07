import 'package:bloc/bloc.dart';
import 'package:carrent/Features/Core/Car/Service/CarService.dart';
import 'package:carrent/Features/Core/Packages/Service/PackagesService.dart';
import 'package:carrent/Models/Car.dart';
import 'package:carrent/Models/Package.dart';
import 'package:meta/meta.dart';

part 'all_packages_state.dart';

class AllPackagesCubit extends Cubit<AllPackagesState> {
  int page = 0;
  final List<Package> packages = [];
  final services = PackagesService();
  AllPackagesCubit() : super(AllPackagesInitial()) {
    getData();
  }

  String search = "";

  void getData() async {
    packages.clear();

    emit(AllPackagesLoadingState());
    final res = await services.getPackages();

    if (res != null) {
      packages.addAll(res);
      emit(AllPackagesSuccesState());
    } else {
      emit(AllPackagesFailState());
    }
  }
}
