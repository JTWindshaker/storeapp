import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/home/domain/use_case/delete_product_use_case.dart';
import 'package:storeapp/app/home/domain/use_case/get_products_use_case.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/home/presentation/bloc/home_state.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  HomeBloc({
    required this.getProductsUseCase,
    required this.deleteProductUseCase,
  }) : super(LoadingState()) {
    on<GetProductsEvent>(_getProductsEvent);
    on<DeleteProductEvent>(_deleteProductEvent);
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
      // throw (Exception());
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
      // newState = LoadingState();
      // emit(newState);

      final bool result = await deleteProductUseCase.invoke(event.id);

      if (result) {
        // _getProductsEvent(GetProductsEvent(), emit);
        newState = LoadingState();
        emit(newState);

        final List<ProductModel> result = await getProductsUseCase.invoke();
        // throw (Exception());
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

      emit(newState);
    }
  }
}
