import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:greenify/register/authenication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final fullname = TextEditingController();
  final email =  TextEditingController();
  final phoneno = TextEditingController();
  final password = TextEditingController();


  void registerUser (String email , String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email , password);
  }
}