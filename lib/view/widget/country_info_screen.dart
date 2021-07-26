import 'package:covid/cubit/country_info_cubit.dart';
import 'package:covid/cubit/country_info_state.dart';
import 'package:covid/model/country.dart';
import 'package:covid/view/widget/error_widget.dart';
import 'package:covid/view/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'basic_row.dart';

class CountryInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryInfoCubit, CountryInfoState>(
      builder: (BuildContext context, CountryInfoState state) {
        if (state is CountryInfoLoaded) {
          Country country = state.country;
          return CustomScrollView(
            slivers: [
              SliverList(delegate: SliverChildListDelegate(
                [
                  BasicRow('Name', country.name ?? 'n/a'),
                  BasicRow('Capital', country.capital ?? 'n/a'),
                  BasicRow('Native Name', country.nativeName ?? 'n/a'),
                  BasicRow('Alpha2Code', country.alpha2Code ?? 'n/a'),
                  BasicRow('Alpha3Code', country.alpha3Code ?? 'n/a'),
                  BasicRow('Region', country.region ?? 'n/a'),
                  BasicRow('Subregion', country.subRegion ?? 'n/a'),
                  BasicRow('Population', country.population.toString()),
                  BasicRow('Demonym', country.demonym ?? 'n/a'),
                  BasicRow('Area', country.area.toString()),
                  BasicRow('Gini', country.gini.toString()),
                  BasicRow('NumericCode', country.numericCode ?? 'n/a'),
                  BasicRow('Cioc', country.cioc ?? 'n/a'),
                  _buildOtherInfo(),
                  NestedTabBar(country),
                ]
              ),)
            ],
          );
        }

        if(state is CountryInfoError){
          return CustomErrorWidget();
        }

        return LoadingWidget();
      },
    );
  }

  Widget _buildOtherInfo() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 17, bottom: 8),
        child: Text(
          "Other Info",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class NestedTabBar extends StatefulWidget {
  NestedTabBar(this.country);

  final Country country;

  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.orange,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 17),
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: <Widget>[
            Tab(text: "Time Zones"),
            Tab(text: "Borders"),
            Tab(text: "Currencies"),
            Tab(text: "Languages"),
          ],
        ),
        Container(
          color: Colors.grey[300],
          height: screenHeight * .20,
          margin: EdgeInsets.all(16),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              _buildTimeZoneSection(),
              _buildBorderSection(),
              _buildCurrencySection(),
              _buildLanguageSection(),
            ],
          ),
        )
      ],
    );
  }

  ListView _buildLanguageSection() {
    return ListView.builder(
      padding: EdgeInsets.all(17),
      itemBuilder: (BuildContext context, int index) {
        Language language = widget.country.languages[index];
        return Column(
          children: [
            BasicRow('Name', language.name ?? ''),
            BasicRow('Native Name', language.nativeName ?? ''),
            BasicRow('Iso639_1', language.iso639_1 ?? ''),
            BasicRow('Iso639_2', language.iso639_2 ?? ''),
          ],
        );
      },
      itemCount: widget.country.languages.length,
    );
  }

  ListView _buildCurrencySection() {
    return ListView.builder(
      padding: EdgeInsets.all(17),
      itemBuilder: (BuildContext context, int index) {
        Currency currency = widget.country.currencies[index];
        return Column(
          children: [
            BasicRow('Name', currency.name ?? ''),
            BasicRow('Code', currency.code ?? ''),
            BasicRow('Symbol Name', currency.symbol ?? ''),
          ],
        );
      },
      itemCount: widget.country.currencies.length,
    );
  }

  ListView _buildBorderSection() {
    return ListView.builder(
      padding: EdgeInsets.all(17),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            widget.country.borders[index],
            style: TextStyle(fontSize: 18),
          ),
        );
      },
      itemCount: widget.country.borders.length,
    );
  }

  ListView _buildTimeZoneSection() {
    return ListView.builder(
      padding: EdgeInsets.all(17),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            widget.country.timezones[index],
            style: TextStyle(fontSize: 18),
          ),
        );
      },
      itemCount: widget.country.timezones.length,
    );
  }
}
