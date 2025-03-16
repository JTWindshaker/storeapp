import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/users/presentation/bloc/users_bloc.dart';
import 'package:storeapp/app/users/presentation/bloc/users_event.dart';
import 'package:storeapp/app/users/presentation/bloc/users_state.dart';
import 'package:storeapp/app/users/presentation/model/users_model.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<UsersBloc>(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBarWidget(),
        ),
        body: ProductsListWidget(),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFEF1D26),
      title: Text("Listado de Usuarios", style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(
          icon: Icon(Icons.card_giftcard, color: Colors.white),
          onPressed: () => GoRouter.of(context).pushReplacementNamed("home"),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }
}

// Es un statefull para poder repintar esto de manera recursiva
class ProductsListWidget extends StatefulWidget {
  const ProductsListWidget({super.key});

  @override
  State<ProductsListWidget> createState() => _ProductsListWidgetState();
}

class _ProductsListWidgetState extends State<ProductsListWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UsersBloc>();
    print("😁😁😁😁USERS load😁😁😁😁");
    bloc.add(GetUsersEvent());

    // El block consumer es la fusión del bloc builder y listener
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {
        // Nada gráfico, mostrar alertas o hacer otras mientras se realizan las peticiones. Se definen todos los estados
        switch (state) {
          case LoadingState() || EmptyState() || LoadDataState():
            break;
          case UsersErrorState():
            showDialog(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error!!'),
                  content: SingleChildScrollView(
                    child: ListBody(children: <Widget>[Text(state.message)]),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cerrar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        bloc.add(GetUsersEvent());
                      },
                    ),
                  ],
                );
              },
            );
            break;
        }
      },
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20.0),
                  Text(state.message),
                ],
              ),
            );
          case EmptyState():
            return Center(child: Text("No se encontró data"));
          case LoadDataState():
            return ListView.builder(
              itemCount: state.model.users.length,
              itemBuilder:
                  (context, index) =>
                      ProductItemWidget(product: state.model.users[index]),
            );
          default:
            return Center(child: Text("NINGUN ESTADO ES VÁLIDO"));
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final UsersModel product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen del producto
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // Información del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.id,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.email,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
