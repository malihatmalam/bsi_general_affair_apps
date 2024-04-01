part of 'asset_detail_cubit.dart';

abstract class AssetDetailState extends Equatable {
  const AssetDetailState();
  @override
  List<Object> get props => [];
}

class AssetDetailInitial extends AssetDetailState {}

class AssetDetailLoading extends AssetDetailState {}

class AssetDetailLoaded extends AssetDetailState {
  final AssetsModel asset;
  const AssetDetailLoaded({required this.asset});

  @override
  List<Object> get props => [asset];
}

class AssetDetailError extends AssetDetailState{
  final String message;
  const AssetDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
