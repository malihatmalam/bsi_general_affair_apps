
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_bar_event.dart';
part 'bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  BottomBarBloc() : super( const BottomBarInitial(tabIndex: 0)) {
    on<BottomBarEvent>((event, emit) {
      // TODO: implement event handler
      if(event is TabChange) {
        print(event.tabIndex);
        emit(BottomBarInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
