import 'package:device_preview/device_preview.dart';
import 'package:irish_locums/app/view/app.dart';
import 'package:irish_locums/bootstrap.dart';
import 'package:irish_locums/features/auth/data/authRepository.dart';
import 'package:irish_locums/features/home/data/appliactions_repository.dart';
import 'package:irish_locums/features/home/data/branches_repositiory.dart';
import 'package:irish_locums/features/home/data/jobs_repository.dart';
import 'package:provider/provider.dart';

void main() {
  bootstrap(() => const App());
  bootstrap(
    () => DevicePreview(
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthRepository()),
          ChangeNotifierProvider(create: (_) => JobsRepository()),
          ChangeNotifierProvider(create: (_) => BranchesRepository()),
          ChangeNotifierProvider(create: (_) => ApplicationsRepository()),
          // Add any additional providers here
        ],
        child: const App(),
      ),
    ),
  );
}
