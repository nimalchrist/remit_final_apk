import 'package:Habo/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<Bloc>(context);
    return Container(
      height: 80.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: bloc.getWeekStartList.length,
        itemBuilder: (
          BuildContext ctx,
          int index,
        ) {
          int start = bloc.getWeekStartEnum.index;
          int day = (start + index) % bloc.getWeekStartList.length;
          TextStyle tex =
              TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0));
          if (bloc.getWeekStartList[day] == "Sa" ||
              bloc.getWeekStartList[day] == "Su") {
            tex = TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 234, 85, 85));
          }
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 99, 97, 97),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: (MediaQuery.of(context).size.width - 32) * 0.141,
            child: Center(
              child: Text(bloc.getWeekStartList[day], style: tex),
            ),
          );
        },
      ),
    );
  }
}
