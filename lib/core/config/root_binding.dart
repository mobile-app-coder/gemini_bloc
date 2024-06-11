import 'package:gemini_app/presentation/controllers/home_controller.dart';
import 'package:gemini_app/presentation/controllers/starter_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(),fenix: true);
    Get.lazyPut(() => StarterController(),fenix: true);
  }
}
