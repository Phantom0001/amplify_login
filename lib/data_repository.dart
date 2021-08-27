import 'package:amplify_flutter/amplify.dart';
import 'models/User.dart';

class DataRepository {
  // Query the database for a user where the userId is equal to this userId.
  Future<User?> getUserById(String userId) async {
    try {
      final users = await Amplify.DataStore.query(
        User.classType,
        where: User.ID.eq(userId),
      );
      return users.isNotEmpty
          ? users.first
          : null; // return user if no user then return none.
    } catch (e) {
      throw e;
    }
  }

  // takes in userId, username, and email.. which is already provided by our
  // AuthCredential file.
  // we take the user object then pass it into the DataStore.save function
  // if it is executed successfully then it will return the new User.
  Future<User?> createUser({
    String? userId,
    required String username,
    String? email,
  }) async {
    final newUser = User(id: userId, username: username, email: email);
    try {
      await Amplify.DataStore.save(newUser);
      return newUser;
    } catch (e) {
      throw e;
    }
  }
}
