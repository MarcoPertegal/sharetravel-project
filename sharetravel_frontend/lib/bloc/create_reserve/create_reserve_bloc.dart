import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharetravel_frontend/model/dto/new_reserve_dto.dart';
import 'package:sharetravel_frontend/model/response/create_reserve_response.dart';
import 'package:sharetravel_frontend/repository/create_reserve/create_reserve_repository.dart';

part 'create_reserve_event.dart';
part 'create_reserve_state.dart';

class CreateReserveBloc extends Bloc<CreateReserveEvent, CreateReserveState> {
  final CreateReserveRepository createReserveRepository;

  CreateReserveBloc(this.createReserveRepository)
      : super(CreateReserveInitial()) {
    on<DoCreateReserveEvent>(_doCreateReserve);
  }

  Future<void> _doCreateReserve(
      DoCreateReserveEvent event, Emitter<CreateReserveState> emit) async {
    emit(DoCreateReserveLoading());

    try {
      final NewReserveDto newReserveDto = NewReserveDto(tripId: event.id);
      final response =
          await createReserveRepository.createReserve(newReserveDto);
      emit(DoCreateReserveSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoCreateReserveError(e.toString()));
    }
  }
}
