import 'package:bloc/bloc.dart';
import 'package:bsi_general_affair_apps/data/models/homepages/homepages_model.dart';
import 'package:bsi_general_affair_apps/domain/usecases/homepages_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../domain/failures/failures.dart';

part 'homepage_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class HomepageCubit extends Cubit<HomepageState> {
  final HomepagesUseCases _homepagesUseCases = HomepagesUseCases();
  String? typeProposal;
  HomepageCubit() : super(HomepageInitial()){
    HomepageGetData();
  }

  void HomepageGetData() async {
    var box = Hive.box('userdata');
    emit(HomepageLoading());
    final failureOrHomepage = await _homepagesUseCases.getHomepageData(box.get('employeeNumber'));
    failureOrHomepage.fold(
            (failure) => emit(HomepageError(message: _mapFailureToMessage(failure))),
            (homepage) => emit(HomepageLoaded(homepage: homepage))
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
