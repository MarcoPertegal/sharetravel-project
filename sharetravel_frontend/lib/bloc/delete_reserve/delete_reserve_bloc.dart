import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/repository/delete_reserve/delete_reserve_repository.dart';

part 'delete_reserve_event.dart';
part 'delete_reserve_state.dart';

class DeleteReserveBloc extends Bloc<DeleteReserveEvent, DeleteReserveState> {
  final DeleteReserveRepository deleteReserveRepository;
  DeleteReserveBloc(this.deleteReserveRepository)
      : super(DeleteReserveInitial()) {
    on<DoDeleteReserveEvent>(_doDeleteReserve);
  }

  Future<void> _doDeleteReserve(
      DoDeleteReserveEvent event, Emitter<DeleteReserveState> emit) async {
    emit(DoDeleteReserveLoading());

    try {
      await deleteReserveRepository.deleteReserve(event.id);
      emit(DoDeleteReserveSuccess());
      return;
    } on Exception catch (e) {
      emit(DoDeleteReserveError(e.toString()));
    }
  }
}
