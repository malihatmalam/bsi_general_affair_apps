import 'package:bloc/bloc.dart';
import 'package:bsi_general_affair_apps/data/models/users/users_model.dart';
import 'package:bsi_general_affair_apps/domain/usecases/users_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../domain/failures/failures.dart';

part 'profile_page_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  final UsersUseCases _usersUseCases = UsersUseCases();
  ProfilePageCubit() : super(ProfilePageInitial()){
    userGetData();
  }

  void userGetData() async {
    var box = Hive.box('userdata');
    emit(ProfilePageLoading());
    final failureOrUser = await _usersUseCases.getUserByUsernameData(box.get('username'));
    failureOrUser.fold(
            (failure) => emit(ProfilePageError(message: _mapFailureToMessage(failure))),
            (user) => emit(ProfilePageLoaded(user: user))
    );
  }

  String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
