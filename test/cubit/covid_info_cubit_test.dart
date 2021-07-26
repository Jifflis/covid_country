import 'package:covid/cubit/covid_info_cubit.dart';
import 'package:covid/cubit/covid_info_state.dart';
import 'package:covid/model/covid_country.dart';
import 'package:covid/repository/covid_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'covid_info_cubit_test.mocks.dart';

@GenerateMocks(<Type>[CovidRepository])
void main() {
  CovidRepository repository = MockCovidRepository();
  CovidInfoCubit cubit = CovidInfoCubit(repository);

  group('Covid Info cubit test', () {
    test('should emit [LOADING, Loaded] when response is success', () async {
      CovidCountry country = CovidCountry(country: 'Philippines');

      when(repository.getInfectedCountry(any)).thenAnswer((_) async => country);

      final expected = [
        isA<CovidInfoLoading>(),
        isA<CovidInfoLoaded>(),
      ];

      expectLater(cubit.stream, emitsInOrder(expected));

      await cubit.getInfectedCountry('');
    });

    test('should emit [LOADING, ERROR] when response is error', () async {
      when(repository.getInfectedCountry(any)).thenThrow(Exception());

      final expected = [
        isA<CovidInfoLoading>(),
        isA<CovidInfoError>(),
      ];

      expectLater(cubit.stream, emitsInOrder(expected));

      await cubit.getInfectedCountry('');
    });
  });
}
