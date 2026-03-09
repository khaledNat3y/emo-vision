import 'package:facial_emotional_detection_graduation_project/core/services/firebase_services.dart';
import 'package:facial_emotional_detection_graduation_project/features/home/data/model/user_model.dart';

class HomeRepo {
  final FirebaseServices firebaseServices;

  HomeRepo(this.firebaseServices);


   UserModel? getCurrentUserInfo() {
    final UserModel? userInfo = firebaseServices.getCurrentUserInfo();
    return userInfo;
   }


}