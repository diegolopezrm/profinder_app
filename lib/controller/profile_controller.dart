import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:profinder_app/utils/user_repository.dart';

class ProfileController {
  static ProfileController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());

  getUserData(){
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid != null){
      return _userRepo.getUserDetails(uid);
    } else {
      Get.snackbar("Error", "Algo salio mal en profile controller");
    }
  }
}