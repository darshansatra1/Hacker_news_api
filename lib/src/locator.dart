import 'package:get_it/get_it.dart';
import 'bloc/comments_bloc.dart';
import 'bloc/news_bloc.dart';

void setUpLocator() {
  GetIt getIt = GetIt.I;
  getIt.registerLazySingleton(() => NewsBloc());
  getIt.registerLazySingleton(() => CommentsBloc());
}
