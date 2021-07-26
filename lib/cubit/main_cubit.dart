import 'package:bloc/bloc.dart';
import 'package:covid/cubit/main_state.dart';
import 'package:covid/repository/covid_repository.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this._covidRepository) : super(MainLoading());

  CovidRepository _covidRepository;

  Future<void> getInfectedCountry() async {
    try {
      emit(MainLoading());
      emit(MainLoaded(await _covidRepository.getInfectedCountries()));
    } catch (e) {
      emit(MainError(e.toString()));
    }
  }
}
