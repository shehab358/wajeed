import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:wajeed/features/home/presentation/cubit/home_states.dart';

@lazySingleton
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
}
