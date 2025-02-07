import 'package:fuel_delivary_app_admin/config/firebase_configarations.dart';
import 'package:fuel_delivary_app_admin/model/user_model.dart';

class UserService {
  Stream<List<User>> getUsersStream() {
    try {
      return FireSetup.users.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          print("doc data is ${doc.data()}");
          var user = User.fromJson({"id": doc.id, ...doc.data()});
          print("users name is ${user.name}");
          return user;
        }).toList();
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
