import 'package:flutter/material.dart';

class DropdownDate extends StatelessWidget {
  const DropdownDate({
    Key? key,
    required this.monthKey,
    required this.monthController,
    required this.yearKey,
    required this.yearController,
    required this.selectYear,
    required this.selectMonth,
  }) : super(key: key);
  final GlobalKey<FormFieldState> monthKey;
  final String? monthController;
  final GlobalKey<FormFieldState> yearKey;
  final String? yearController;
  final void Function(String?)? selectYear;
  final void Function(String?)? selectMonth;
  final String emptyError = 'Le champ ne peut être vide';
  final String monthHint = 'MM';
  final String yearHint = 'YY';

  String? checkEmptyValue(value) {
    if (value == null || value.isEmpty) {
      return emptyError;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<String> generateListYears() {
      int currentYear = DateTime.now().year;
      List<String> yearList = [];
      for (var year = currentYear; year < currentYear + 12; year++) {
        yearList.add(year.toString().substring(year.toString().length - 2));
      }
      return yearList;
    }

    List<String> listMonths = [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ];

    List<String> listYears = generateListYears();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          child: DropdownButtonFormField(
            key: monthKey,
            value: monthController,
            validator: checkEmptyValue,
            menuMaxHeight: 300.0,
            hint: Text(monthHint),
            onChanged: selectMonth,
            items: listMonths.map((String month) {
              return DropdownMenuItem(
                child: Text(month),
                value: month,
              );
            }).toList(),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('/'),
        ),
        SizedBox(
          width: 120,
          child: DropdownButtonFormField(
            key: yearKey,
            menuMaxHeight: 300.0,
            value: yearController,
            validator: checkEmptyValue,
            hint: Text(yearHint),
            onChanged: selectYear,
            items: listYears.map((String year) {
              return DropdownMenuItem(
                child: Text(year),
                value: year,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
