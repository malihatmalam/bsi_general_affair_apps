part of 'asset_list_cubit.dart';

abstract class AssetListState extends Equatable {
  const AssetListState();
  @override
  List<Object> get props => [];
}

class AssetListInitial extends AssetListState {}

class AssetListLoading extends AssetListState {}

class AssetListLoaded extends AssetListState {
  final List<AssetsModel> assets;
  const AssetListLoaded({required this.assets});

  @override
  List<Object> get props => [assets];
}

class AssetListError extends AssetListState{
  final String message;
  const AssetListError({required this.message});

  @override
  List<Object> get props => [message];
}
