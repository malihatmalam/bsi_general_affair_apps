part of 'bottom_bar_bloc.dart';

@immutable
abstract class BottomBarState {
  final int tabIndex;
  const BottomBarState({required this.tabIndex});
}

class BottomBarInitial extends BottomBarState {
  const BottomBarInitial({required super.tabIndex});
}
