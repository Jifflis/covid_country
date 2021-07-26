import 'package:covid/cubit/country_info_cubit.dart';
import 'package:covid/cubit/country_info_state.dart';
import 'package:covid/model/country.dart';
import 'package:covid/repository/country_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'country_info_cubit_test.mocks.dart';

@GenerateMocks(<Type>[CountryRepository])
void main() {
  CountryRepository repository = MockCountryRepository();
  CountryInfoCubit cubit = CountryInfoCubit(repository);

  group('Country Info cubit test', () {
    test('should emit [LOADING, Loaded] when response is success', () async {
      Country country = Country(name: 'USA');

      when(repository.getCountryDetails(any)).thenAnswer((_) async => country);

      final expected = [
        isA<CountryInfoLoading>(),
        isA<CountryInfoLoaded>(),
      ];

      expectLater(cubit.stream, emitsInOrder(expected));

      await cubit.getCountryDetails('USA');
    });

    test('should emit [LOADING, ERROR] when response is error', () async {
      when(repository.getCountryDetails(any)).thenThrow(Exception());

      final expected = [
        isA<CountryInfoLoading>(),
        isA<CountryInfoError>(),
      ];

      expectLater(cubit.stream, emitsInOrder(expected));

      await cubit.getCountryDetails('USA');
    });
  });
}
