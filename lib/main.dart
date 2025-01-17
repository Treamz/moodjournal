import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodjournal/features/app/app.dart';

import 'features/app/view/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider.value(value: authenticationRepository),
    ],
    child: MultiBlocProvider(providers: [
      BlocProvider<AppBloc>(
          create: (_) =>
              AppBloc(authenticationRepository: authenticationRepository))
    ], child: AppView()),
  ));
}
