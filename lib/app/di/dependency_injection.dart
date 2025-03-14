import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:storeapp/app/core/data/remote/services/product_service.dart';
import 'package:storeapp/app/core/data/repository/sesion_repository_imp.dart';
import 'package:storeapp/app/core/domain/repository/sesion_repository.dart';
import 'package:storeapp/app/core/domain/use_case/logout_use_case.dart';
import 'package:storeapp/app/form_product/data/repository/form_product_repository_impl.dart';
import 'package:storeapp/app/form_product/domain/repository/form_product_repository.dart';
import 'package:storeapp/app/form_product/domain/use_case/add_product_use_case.dart';
import 'package:storeapp/app/form_product/domain/use_case/get_product_use_case.dart';
import 'package:storeapp/app/form_product/domain/use_case/update_product_use_case.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_bloc.dart';
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

  //Inyección de DIO
  static setup() {
    //Inyección del Dio
    serviceLocator.registerSingleton<Dio>(Dio());

    //Inyección del service
    serviceLocator.registerFactory<ProductService>(
      () => ProductService(dio: serviceLocator.get()),
    );

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
    serviceLocator.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(productService: serviceLocator.get()),
    );

    //Inyección del Caso de uso
    serviceLocator.registerFactory<GetProductsUseCase>(
      () => GetProductsUseCase(homeRepository: serviceLocator.get()),
    );

    //Inyección del Caso de uso
    serviceLocator.registerFactory<DeleteProductUseCase>(
      () => DeleteProductUseCase(homeRepository: serviceLocator.get()),
    );

    serviceLocator.registerFactory<SesionRepository>(
      () => SesionRepositoryImp(),
    );

    serviceLocator.registerFactory<LogoutUseCase>(
      () => LogoutUseCase(sesionRepository: serviceLocator.get()),
    );

    //Inyección del Bloc
    serviceLocator.registerFactory<HomeBloc>(
      () => HomeBloc(
        deleteProductUseCase: serviceLocator.get(),
        getProductsUseCase: serviceLocator.get(),
        logoutUseCase: serviceLocator.get(),
      ),
    );

    // Inyección del Form Product
    //Inyección del Repositorio
    serviceLocator.registerFactory<FormProductRepository>(
      () => FormProductRepositoryImpl(productService: serviceLocator.get()),
    );

    //Inyección del Caso de uso
    serviceLocator.registerFactory<AddProductUseCase>(
      () => AddProductUseCase(formProductRepository: serviceLocator.get()),
    );

    //Inyección del Caso de uso
    serviceLocator.registerFactory<GetProductUseCase>(
      () => GetProductUseCase(formProductRepository: serviceLocator.get()),
    );

    //Inyección del Caso de uso
    serviceLocator.registerFactory<UpdateProductUseCase>(
      () => UpdateProductUseCase(formProductRepository: serviceLocator.get()),
    );

    //Inyección del Bloc
    serviceLocator.registerFactory<FormProductBloc>(
      () => FormProductBloc(
        addProductUseCase: serviceLocator.get(),
        getProductUseCase: serviceLocator.get(),
        updateProductUseCase: serviceLocator.get(),
      ),
    );
  }
}
