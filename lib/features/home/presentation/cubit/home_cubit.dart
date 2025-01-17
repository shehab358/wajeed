import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajeed/features/home/presentation/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
}
