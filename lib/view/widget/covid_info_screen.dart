import 'package:covid/cubit/covid_info_cubit.dart';
import 'package:covid/cubit/covid_info_state.dart';
import 'package:covid/model/covid_country.dart';
import 'package:covid/model/infected_region.dart';
import 'package:covid/view/widget/error_widget.dart';
import 'package:covid/view/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'basic_row.dart';

class CovidInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CovidInfoCubit, CovidInfoState>(
      listener: (BuildContext context, CovidInfoState state) {},
      builder: (BuildContext context, CovidInfoState state) {
        if (state is CovidInfoLoaded) {
          final CovidCountry covidCountry = state.covidCountry;
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  BasicRow('Country', covidCountry.country ?? 'n/a'),
                  BasicRow('Hospitalized', covidCountry.hospitalized ?? 'n/a'),
                  BasicRow('Total ICU', covidCountry.totalIcu ?? 'n/a'),
                  BasicRow('Available Hospital Beds',covidCountry.availbleHospitalBeds ?? 'n/a'),
                  BasicRow('Available ICU Beds', covidCountry.availbleIcuBeds ?? 'n/a'),
                  BasicRow('Infected', covidCountry.infected ?? 'n/a'),
                  BasicRow('Tested', covidCountry.tested ?? 'n/a'),
                  BasicRow('Recovered', covidCountry.recovered ?? 'n/a'),
                  BasicRow('Deceased', covidCountry.deceased ?? 'n/a'),
                  BasicRow('Active', covidCountry.active ?? 'n/a'),
                  BasicRow('Last Update', covidCountry.lastupdate.toString()),
                  _buildRegions(),
                  _buildRegionList(covidCountry.infectedRegions),
                ]),
              ),
            ],
          );
        }
        if (state is CovidInfoError) {
          return CustomErrorWidget();
        }

        return LoadingWidget();
      },
    );
  }

  Widget _buildRegions() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 17, top: 32, bottom: 8),
        child: Text(
          "Infected Regions",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildRegionList(List<InfectedRegion> regions) {
    return regions.length == 0
        ? Center(child: Text('n/a'))
        : Container(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(17),
              itemBuilder: (BuildContext context, int index) {
                InfectedRegion region = regions[index];
                return Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  color: Colors.grey[300],
                  child: Column(
                    children: [
                      BasicRow('', region.regionName ?? ''),
                      BasicRow('Infected: ', region.infected ?? ''),
                      BasicRow('Recovered: ', region.recovered ?? ''),
                      BasicRow('Deceased: ', region.deceased ?? ''),
                      BasicRow('Active: ', region.active ?? ''),
                    ],
                  ),
                );
              },
              itemCount: regions.length,
            ),
          );
  }
}
