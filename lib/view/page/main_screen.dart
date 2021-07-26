import 'package:covid/constant/routes.dart';
import 'package:covid/cubit/main_cubit.dart';
import 'package:covid/cubit/main_state.dart';
import 'package:covid/model/covid_country.dart';
import 'package:covid/view/widget/custom_expanded_list.dart';
import 'package:covid/view/widget/error_widget.dart';
import 'package:covid/view/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of country with covid'),
      ),
      body: BlocConsumer<MainCubit, MainState>(
        listener: (BuildContext context, MainState state) {
          if (state is MainError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error loading!'),
              ),
            );
          }
        },
        builder: (BuildContext context, MainState state) {
          if (state is MainError) {
            return CustomErrorWidget();
          }
          if (state is MainLoaded) {
            return _buildList(state.covidCountries);
          }
          return LoadingWidget();
        },
      ),
    );
  }

  ReorderableListView _buildList(List<CovidCountry> covidCountries) {
    return ReorderableListView.builder(
      scrollController: ScrollController(initialScrollOffset: 50),
      itemBuilder: (_, int index) {
        return Item(
            covidCountry: covidCountries[index], key: ValueKey<int>(index));
      },
      itemCount: covidCountries.length,
      onReorder: (int oldIndex, int newIndex) {
        covidCountries.insert(
          newIndex - (newIndex < oldIndex ? 0 : 1),
          covidCountries.removeAt(oldIndex),
        );
      },
    );
  }
}

class Item extends StatelessWidget {
  const Item({required this.covidCountry, Key? key}) : super(key: key);

  final CovidCountry covidCountry;

  @override
  Widget build(BuildContext context) {
    return CustomExpandedList(
      onTap: () {
        Navigator.pushNamed(context, Routes.screen_detail,
            arguments: covidCountry);
      },
      highlight: (int.tryParse(covidCountry.deceased ?? '0') ?? 0) > 100000
          ? true
          : false,
      title: covidCountry.country.toString(),
      child: ReorderableListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, int index) {
          return Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(left: 17),
            key: Key('$index'),
            child: Text(
              '${covidCountry.covidInfo[index].entries.first.key}: '
              '${covidCountry.covidInfo[index].entries.first.value}',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          );
        },
        itemCount: covidCountry.covidInfo.length,
        onReorder: (int oldIndex, int newIndex) {
          covidCountry.covidInfo.insert(
            newIndex - (newIndex < oldIndex ? 0 : 1),
            covidCountry.covidInfo.removeAt(oldIndex),
          );
        },
      ),
    );
  }
}
