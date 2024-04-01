import 'package:bloc/bloc.dart';
import 'package:bsi_general_affair_apps/domain/usecases/assets_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../data/models/assets/assets_model.dart';
import '../../../../domain/failures/failures.dart';

part 'asset_list_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class AssetListCubit extends Cubit<AssetListState> {
  final AssetsUseCases _assetsUseCases = AssetsUseCases();
  AssetListCubit() : super(AssetListInitial()){
    assetListGetData();
  }

  void assetListGetData() async {
    var box = Hive.box('userdata');
    emit(AssetListLoading());
    final failureOrAssetList = await _assetsUseCases.getAssetByEmployeeNumber(box.get('employeeNumber'));
    failureOrAssetList.fold(
            (failure) => emit(AssetListError(message: _mapFailureToMessage(failure))),
            (assets) => emit(AssetListLoaded(assets: assets))
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
