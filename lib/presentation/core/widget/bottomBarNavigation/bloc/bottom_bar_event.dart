part of 'bottom_bar_bloc.dart';

@immutable
abstract class BottomBarEvent {}

class TabChange extends BottomBarEvent{
  final int tabIndex;
  TabChange({required this.tabIndex});
}
