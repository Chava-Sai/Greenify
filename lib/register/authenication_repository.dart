import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:greenify/home/weather.dart';

import 'failure.dart';
import 'login.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => LoginPage()) : Get.offAll(() => WeatherPage());
  }

  Future<void> createUserWithEmailAndPassword(String email , String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => WeatherPage()) : Get.to(() => LoginPage());
    } on FirebaseAuthException catch(e){
      final ex =  SignUpWithEmailAndPassFailure.code(e.code);
      print('FireBase Auth Exception - ${ex.message}');
      throw ex;
    } catch (_){
      const ex =  SignUpWithEmailAndPassFailure();
      print(' Exception - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email , String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
    } catch (_){}
  }

  Future<void> logout() async => _auth.signOut();


}