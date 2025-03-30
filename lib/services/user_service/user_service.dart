import 'package:fuel_delivary_app_admin/config/firebase_configurations.dart';
import 'package:fuel_delivary_app_admin/model/user_model.dart';

class UserService {
  Stream<List<User>> getUsersStream() {
    try {
      return FireSetup.users.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
        
          var user = User.fromJson({"id": doc.id, ...doc.data()});
      
          return user;
        }).toList();
      });
    } catch (e) {
   
      rethrow;
    }
  }
}
