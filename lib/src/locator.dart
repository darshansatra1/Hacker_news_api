import 'package:get_it/get_it.dart';
import 'package:hacker_news/src/resources/news_api_provider.dart';
import 'package:hacker_news/src/resources/news_db_provider.dart';

import 'bloc/news_bloc.dart';

void setUpLocator() {
  GetIt getIt = GetIt.I;
  getIt.registerLazySingleton(() => NewsBloc());
  getIt.registerLazySingleton(() => NewsDbProvider());
  getIt.registerLazySingleton(() => NewsApiProvider());
}
