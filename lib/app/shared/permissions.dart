import 'package:irish_locums/app/shared/shared_pref_helper.dart';

class Permissions {
  SharedPrefHelper prefHelper = SharedPrefHelper();

  bool isEmployee = false;
  bool isEmployer = false;

  isEmployerOrEmployee() async {
    await prefHelper.init();
    String? role = prefHelper.getValue('role');
    if (role == 'employee') {
      isEmployee = true;
    } else if (role == 'employer') {
      isEmployer = true;
    }
  }
}
