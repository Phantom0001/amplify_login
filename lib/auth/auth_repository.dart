import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

class AuthRepository {
  // async function that returns a string that will fetch the users attribute
  // will return the user id, if not, then it will throw an error.
  Future<String> _getUserIdFromAttribute() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final userId = attributes
          .firstWhere((element) => element.userAttributeKey == 'sub')
          .value;
      return userId;
    } catch (e) {
      throw e;
    }
  }

  Future<String?> attemptAutoLogin() async {
    try {
      final session =
          await Amplify.Auth.fetchAuthSession(); // is the user signed in or not

      return session.isSignedIn ? (await _getUserIdFromAttribute()) : null;
    } catch (e) {
      throw e;
    }
  }

  Future<String?> login({
    required String? username,
    required String? password,
  }) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username!.trim(), // trimming white spaces
        password: password!.trim(),
      );
      return result.isSignedIn ? (await _getUserIdFromAttribute()) : null;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> signUp({
    required String? username,
    required String? email,
    required String? password,
  }) async {
    final options = CognitoSignUpOptions(userAttributes: {'email': email!.trim()});
    try {
      final result = await Amplify.Auth.signUp(
        username: username!.trim(),
        password: password!.trim(),
        options: options,
      );
      return result.isSignUpComplete;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> confirmSignUp({
    required String? username,
    required String? confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username!.trim(),
        confirmationCode: confirmationCode!.trim(),
      );
      return result.isSignUpComplete;
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }
}
