import 'package:bloc/bloc.dart';
import 'package:covid/repository/covid_repository.dart';

import 'covid_info_state.dart';

class CovidInfoCubit extends Cubit<CovidInfoState>{
  CovidInfoCubit(this._covidRepository) : super(CovidInfoInitialize());

  CovidRepository _covidRepository;

  Future<void> getInfectedCountry(String url)async{
    try{
      emit(CovidInfoLoading());
      print('ok ka 1');
      emit(CovidInfoLoaded(await _covidRepository.getInfectedCountry(url)));
    }catch(_){
      emit(CovidInfoError());
    }
  }
}