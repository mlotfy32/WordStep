import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learning_app/core/utiles/7.1%20bloc_observer.dart';
import 'package:learning_app/core/utiles/checkInternetConnection.dart';
import 'package:learning_app/core/utiles/constans.dart';
import 'package:learning_app/core/utiles/shared_pref/shared_pref.dart';
import 'package:learning_app/features/home/data/cashCourseInfo/cashCource.dart';
import 'package:learning_app/features/saved/data/saveMode.dart';
import 'package:learning_app/features/search/data/local/hiveSearch.dart';
import 'package:learning_app/firebase_options.dart';
import 'package:learning_app/learning_app.dart';

List<String>? courcesChasedName;
void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPref().instantiatePreferences();
  await Hive.initFlutter();
  Hive.registerAdapter(SearchModelAdapter());
  await Hive.openBox<SearchModel>(Constans.hiveSearch);
  Hive.registerAdapter(SaveModelAdapter());
  await Hive.openBox<SaveModel>(Constans.hiveSave);
  Hive.registerAdapter(CashCourceAdapter());
  await Hive.openBox<CashCource>(Constans.hiveCources);
  courcesChasedName =
      await SharedPref.preferences.getList(Constans.courcesChasedName) == null
      ? []
      : await SharedPref.preferences.getList(Constans.courcesChasedName);

  Checkinternetconnection().checkInternetConnection();

  runApp(const LearningApp());
  Bloc.observer = AppBlocObserver();
}
