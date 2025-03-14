import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/core/domain/use_case/logout_use_case.dart';
import 'package:storeapp/app/home/domain/use_case/delete_product_use_case.dart';
import 'package:storeapp/app/home/domain/use_case/get_products_use_case.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/home/presentation/bloc/home_state.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final LogoutUseCase logoutUseCase;

  HomeBloc({
    required this.getProductsUseCase,
    required this.deleteProductUseCase,
    required this.logoutUseCase,
  }) : super(LoadingState()) {
    on<GetProductsEvent>(_getProductsEvent);
    on<DeleteProductEvent>(_deleteProductEvent);
    on<LogoutEvent>(_logoutEvent);
  }

  void _getProductsEvent(
    GetProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    print("😍😍😍😍😍😍😍😍 Entra al cargar 😍😍😍😍😍😍😍😍 ");
    late HomeState newState;

    try {
      newState = LoadingState();
      emit(newState);

      final List<ProductModel> result = await getProductsUseCase.invoke();

      if (result.isEmpty) {
        newState = EmptyState();
      } else {
        newState = LoadDataState(model: state.model.copyWith(products: result));
      }
    } catch (e) {
      newState = HomeErrorState(
        model: state.model,
        message: "Error en obtener los productos",
      );
    }

    emit(newState);
  }

  void _deleteProductEvent(
    DeleteProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    late HomeState newState;

    try {
      final bool result = await deleteProductUseCase.invoke(event.id);

      if (result) {
        newState = LoadingState();
        emit(newState);

        final List<ProductModel> result = await getProductsUseCase.invoke();

        if (result.isEmpty) {
          newState = EmptyState();
        } else {
          newState = LoadDataState(
            model: state.model.copyWith(products: result),
          );
        }
      } else {
        throw (Exception());
      }
    } catch (e) {
      newState = HomeErrorState(
        model: state.model,
        message: "Error al eliminar el producto",
      );
      print("😡 $e");
    }

    emit(newState);
  }

  void _logoutEvent(LogoutEvent event, Emitter<HomeState> emit) async {
    logoutUseCase.invoke();
    emit(LogoutState());
  }
}
