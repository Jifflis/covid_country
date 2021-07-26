import 'package:covid/cubit/country_info_cubit.dart';
import 'package:covid/cubit/country_info_state.dart';
import 'package:covid/cubit/covid_info_cubit.dart';
import 'package:covid/cubit/covid_info_state.dart';
import 'package:covid/model/covid_country.dart';
import 'package:covid/view/widget/country_info_screen.dart';
import 'package:covid/view/widget/covid_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CovidCountry covidCountry =
        ModalRoute.of(context)!.settings.arguments as CovidCountry;

    CountryInfoCubit countryInfoCubit = BlocProvider.of(context);
    if (countryInfoCubit.state is CountryInfoInitialize) {
      countryInfoCubit.getCountryDetails(covidCountry.country ?? '');
    }

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              _buildAppBar(context, covidCountry),
            ];
          },
          body: TabBarView(
            children: [
              CountryInfoScreen(),
              CovidInfoScreen(),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, CovidCountry covidCountry) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      floating: true,
      snap: true,
      pinned: true,
      backgroundColor: Colors.white,
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        background: BlocBuilder<CountryInfoCubit, CountryInfoState>(
          builder: (BuildContext context, CountryInfoState state) {
            if (state is CountryInfoLoaded) {
              return _buildFlag(state);
            }
            return Container();
          },
        ),
      ),
      bottom: _buildtabBar(context, covidCountry),
    );
  }

  Container _buildFlag(CountryInfoLoaded state) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Center(
          child: ClipOval(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.grey.shade200,
          child: SvgPicture.network(
            state.country.flag ?? '',
            fit: BoxFit.cover,
          ),
        ),
      )),
    );
  }

  TabBar _buildtabBar(BuildContext context, CovidCountry covidCountry) {
    return TabBar(
      onTap: (int index) {
        if (index == 1) {
          CovidInfoCubit cubit = BlocProvider.of(context);
          if (cubit.state is CovidInfoInitialize) {
            cubit.getInfectedCountry(covidCountry.moreDataUrl ?? '');
          }
        }
      },
      tabs: [
        Tab(
          icon: Icon(
            Icons.call,
            color: Colors.black,
          ),
          child: Text(
            'Country Info',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Tab(
          icon: Icon(
            Icons.message,
            color: Colors.black,
          ),
          child: Text(
            'Covid Info',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
