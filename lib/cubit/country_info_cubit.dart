import 'package:bloc/bloc.dart';
import 'package:covid/cubit/country_info_state.dart';
import 'package:covid/repository/country_repository.dart';

class CountryInfoCubit extends Cubit<CountryInfoState>{
  CountryInfoCubit(this._countryRepository) : super(CountryInfoInitialize());

  CountryRepository _countryRepository;

  Future<void> getCountryDetails(String countryName)async{
    try{
      emit(CountryInfoLoading());
      emit(CountryInfoLoaded(await _countryRepository.getCountryDetails(countryName)));
    }catch(e){
      emit(CountryInfoError());
    }
  }
}