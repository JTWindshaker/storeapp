import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_event.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_state.dart';
import 'package:storeapp/app/form_product/presentation/pages/form_product_mixin.dart';

class FormProductPage extends StatelessWidget {
  final String? id;
  const FormProductPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<FormProductBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(id == null ? "Agregar Producto" : "Editar Producto"),
        ),
        body: BodyLoginWidget(id),
      ),
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  final String? id;
  const BodyLoginWidget(this.id, {super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget>
    with FormProductMixin {
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormProductBloc>();
    if (widget.id != null) {
      bloc.add(GetProductEvent(widget.id!));
    }

    TextEditingController nameField = TextEditingController();
    TextEditingController priceField = TextEditingController();
    TextEditingController imageField = TextEditingController();

    return BlocListener<FormProductBloc, FormProductState>(
      listener: (context, state) {
        print("👌👌👌DESDE PAGE👌👌👌 $state");
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case SubmitSuccessState():
            print("💕💕💕HACE EL POP💕💕💕 $state");
            GoRouter.of(context).pop();
            // GoRouter.of(context).pushNamed("home");
            break;
          case SubmitErrorState():
            _showMyDialog(state.message);
            break;
        }
      },
      child: BlocBuilder<FormProductBloc, FormProductState>(
        builder: (context, state) {
          nameField.text = state.model.name;
          priceField.text = state.model.price;
          imageField.text = state.model.urlImage;

          return Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameField,
                  // initialValue: state.model.name,
                  onChanged: (value) => bloc.add(NameChangedEvent(name: value)),
                  style: TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: "Nombre del producto",
                    prefixIcon: Icon(
                      Icons.card_giftcard,
                      color: Color(0xFF6F6758),
                    ),
                    hintText: "Nombre del producto",
                    // labelStyle: TextStyle(color: Color(0xFF6F6758)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6F6758)),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 16.0),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // initialValue: state.model.price,
                  controller: priceField,
                  onChanged:
                      (value) => bloc.add(PriceChangedEvent(price: value)),
                  style: TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: "Precio del producto",
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Color(0xFF6F6758),
                    ),
                    hintText: "Precio del producto",
                    // labelStyle: TextStyle(color: Color(0xFF6F6758)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6F6758)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 16.0),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // initialValue: state.model.urlImage,
                  controller: imageField,
                  onChanged:
                      (value) =>
                          bloc.add(UrlImageChangedEvent(urlImage: value)),
                  style: TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: "Imagen del producto",
                    prefixIcon: Icon(Icons.image, color: Color(0xFF6F6758)),
                    hintText: "Imagen del producto",
                    // labelStyle: TextStyle(color: Color(0xFF6F6758)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6F6758)),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 48.0),

                ElevatedButton(
                  onPressed: () => bloc.add(SubmitEvent()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF1D26), // Color principal
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    widget.id == null
                        ? "Guardar Producto"
                        : "Actualizar Producto",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                // Text('Otro Texto'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
