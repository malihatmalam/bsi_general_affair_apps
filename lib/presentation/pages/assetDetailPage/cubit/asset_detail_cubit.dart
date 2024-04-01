import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/assets/assets_model.dart';
import '../../../../domain/failures/failures.dart';
import '../../../../domain/usecases/assets_usecases.dart';

part 'asset_detail_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';


class AssetDetailCubit extends Cubit<AssetDetailState> {
  final AssetsUseCases _assetsUseCases = AssetsUseCases();
  String? assetNumber;
  AssetDetailCubit({required this.assetNumber}) : super(AssetDetailInitial()){
    getAssetDetail(assetNumber!);
  }

  void getAssetDetail(String numberAsset) async {
    emit(AssetDetailLoading());
    final failureOrAssetDetail = await _assetsUseCases.getAssetDetail(numberAsset);
    failureOrAssetDetail.fold(
            (failure) => emit(AssetDetailError(message: _mapFailureToMessage(failure))),
            (asset) => emit(AssetDetailLoaded(asset: asset))
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
