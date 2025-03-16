import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeapp/app/users/data/remote/dto/users_data_model.dart';

final class UsersService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = "users";

  Future<List<UsersDataModel>> getAllUsers() async {
    final List<UsersDataModel> users = [];

    try {
      await _firestore.collection(_collectionPath).get().then((event) {
        for (var doc in event.docs) {
          print("🙌🙌🙌🙌🙌🙌🙌🙌🙌🙌🙌🙌");
          print("${doc.data()}");
          print("🙌🙌🙌🙌🙌🙌🙌🙌🙌🙌🙌🙌");
          users.add(UsersDataModel.fromJson(doc.id, doc.data()));
        }
      });
    } catch (e) {
      throw Exception("Error obteniendo usuarios: $e");
    }

    return users;
  }
}
