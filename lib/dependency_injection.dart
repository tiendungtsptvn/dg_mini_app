import 'package:dg_mini_app/presentation/cubit/global_cubit.dart';
import 'package:get_it/get_it.dart';

void injectDependency() {
  GetIt.I.registerSingleton<GlobalCubit>(
    GlobalCubit()..init(),
  );
}