import 'package:storeapp/app/form_product/presentation/model/product_form_model.dart';

sealed class FormProductState {
  final ProductFormModel model;

  FormProductState({required this.model});
}

final class InitialState extends FormProductState {
  InitialState()
    : super(
        model: ProductFormModel(
          id: "",
          name: "",
          price: "",
          urlImage:
              "https://cdn.shopify.com/s/files/1/0070/7032/articles/product_20research.png?v=1729266020",
        ),
      );
}

final class DataUpdateState extends FormProductState {
  DataUpdateState({required super.model});
}

final class SubmitSuccessState extends FormProductState {
  SubmitSuccessState({required super.model});
}

final class SubmitErrorState extends FormProductState {
  final String message;
  SubmitErrorState({required super.model, required this.message});
}
