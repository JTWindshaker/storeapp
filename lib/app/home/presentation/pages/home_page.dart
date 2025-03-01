import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/home/presentation/bloc/home_bloc.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/home/presentation/bloc/home_state.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<HomeBloc>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFEF1D26),
          title: Text(
            "Listado de Productos",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                GoRouter.of(context).pushReplacementNamed("login");
              },
            ),
            SizedBox(width: 16.0),
          ],
        ),
        body: ProductsListWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).pushNamed("form-product");
          },
          backgroundColor: Color(0xFFEF1D26),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 8,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ), // Ícono más visible
        ),
      ),
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
    final bloc = context.read<HomeBloc>();
    bloc.add(GetProductsEvent());

    // El block consumer es la fusión del bloc builder y listener
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // Nada gráfico, mostrar alertas o hacer otras mientras se realizan las peticiones. Se definen todos los estados
        switch (state) {
          case LoadingState() || EmptyState() || LoadDataState():
            break;
          case HomeErrorState():
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
                        bloc.add(GetProductsEvent());
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
              itemCount: state.model.products.length,
              itemBuilder:
                  (context, index) =>
                      ProductItemWidget(product: state.model.products[index]),
            );
          default:
            return Center(child: Text("NINGUN ESTADO ES VÁLIDO"));
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();

    return InkWell(
      onTap: () {
        GoRouter.of(
          context,
        ).pushNamed("form-product-u", pathParameters: {"id": product.id});
      },
      onLongPress: () {
        showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Eliminación de Producto!'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[Text("Desea Eliminar ${product.name}?")],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Ok", style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    bloc.add(DeleteProductEvent(id: product.id));
                  },
                ),
              ],
            );
          },
        );
      },
      child: Card(
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
                  product.urlImage,
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
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "\$${product.price.toString()}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
