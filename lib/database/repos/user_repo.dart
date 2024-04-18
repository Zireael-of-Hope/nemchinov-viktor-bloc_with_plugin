import 'package:flutter_application_1/database/repos/abstract_repo.dart';
import 'package:flutter_application_1/models/user_back_model.dart';
import 'package:flutter_application_1/objectbox.g.dart';

class UserRepo extends Repository<User> {
  UserRepo(Store store) : box = Box<User>(store);

  @override
  late final Box<User> box;

  @override
  Stream<List<User>> getAllEntitiesInStream() =>
      box.query().watch(triggerImmediately: true).map((query) => query.find());

  Future<User?> getUserByUsername({required String username}) async {
    final Query<User> query =
        box.query(User_.username.equals(username)).build();
    final User? user = query.findFirst();
    query.close();
    return user;
  }

  Future<User?> getUserByEmail({required String email}) async {
    final Query<User> query = box.query(User_.email.equals(email)).build();
    final User? user = query.findFirst();
    query.close();
    return user;
  }
}
