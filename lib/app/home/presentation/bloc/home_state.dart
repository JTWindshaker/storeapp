import 'package:storeapp/app/home/presentation/model/home_model.dart';

sealed class HomeState {
  final HomeModel model;

  HomeState({required this.model});
}

//No tengo nada que mostrarle al usuario
final class EmptyState extends HomeState {
  EmptyState() : super(model: HomeModel(products: []));
}

final class LoadingState extends HomeState {
  final String message;
  LoadingState({this.message = "Cargando Productos..."})
    : super(model: HomeModel(products: []));
}

final class LoadDataState extends HomeState {
  LoadDataState({required super.model});
}

final class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required super.model, required this.message});
}

final class LogoutState extends HomeState {
  LogoutState() : super(model: HomeModel(products: []));
}
