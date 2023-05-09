import 'package:flutter/material.dart';
import 'package:irish_locums/app/view/app.dart';
import 'package:irish_locums/features/auth/data/auth_repository.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthRepository()),
          // Add any additional providers here
        ],
        child: const App(),
      ),
    );
