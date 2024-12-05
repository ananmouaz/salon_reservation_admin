import 'package:get_it/get_it.dart';

import '../boilerplate/pagination/cubits/pagination_cubit.dart';

class ServiceLocator{
  static void registerModels(){
    GetIt.I.registerLazySingleton<CubitStore>(() => CubitStore());

  }

  static refreshServices(){
    GetIt.I<CubitStore>().services.getList();
  }

  static setServices(PaginationCubit services){
    GetIt.I<CubitStore>().services = services;
  }

  static refreshReservations(){
    GetIt.I<CubitStore>().reservations.getList();
  }

  static setReservations(PaginationCubit reservations){
    GetIt.I<CubitStore>().reservations = reservations;
  }

  static refreshTransactions(){
    GetIt.I<CubitStore>().transactions.getList();
  }

  static setTransactions(PaginationCubit transactions){
    GetIt.I<CubitStore>().transactions = transactions;
  }

}

class CubitStore{
  late PaginationCubit services;
  late PaginationCubit reservations;
  late PaginationCubit transactions;
}