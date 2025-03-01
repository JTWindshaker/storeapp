import 'package:get_it/get_it.dart';
import 'package:storeapp/app/home/data/repository/home_repository_impl.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';
import 'package:storeapp/app/home/domain/use_case/delete_product_use_case.dart';
import 'package:storeapp/app/home/domain/use_case/get_products_use_case.dart';
import 'package:storeapp/app/home/presentation/bloc/home_bloc.dart';
import 'package:storeapp/app/login/data/repository/login_repository_impl.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/bloc/login_bloc.dart';

final class DependencyInjection {
  //Constructor privado
  DependencyInjection._();

  static final serviceLocator = GetIt.instance;

  static setup() {
    // Inyección del Login
    //Inyección del Repositorio
    serviceLocator.registerFactory<LoginRepository>(
      () => LoginRepositoryImpl(),
    );

    //Inyección del Caso de uso
    serviceLocator.registerFactory<LoginUseCase>(
      () => LoginUseCase(loginRepository: serviceLocator.get()),
    );

    //Inyección del Bloc
    serviceLocator.registerFactory<LoginBloc>(
      () => LoginBloc(loginUseCase: serviceLocator.get()),
    );

    // Inyección del Home
    //Inyección del Repositorio
    serviceLocator.registerFactory<HomeRepository>(() => HomeRepositoryImpl());

    //Inyección del Caso de uso
    serviceLocator.registerFactory<GetProductsUseCase>(
      () => GetProductsUseCase(homeRepository: serviceLocator.get()),
    );

    //Inyección del Caso de uso
    serviceLocator.registerFactory<DeleteProductUseCase>(
      () => DeleteProductUseCase(homeRepository: serviceLocator.get()),
    );

    //Inyección del Bloc
    serviceLocator.registerFactory<HomeBloc>(
      () => HomeBloc(
        deleteProductUseCase: serviceLocator.get(),
        getProductsUseCase: serviceLocator.get(),
      ),
    );
  }
}
