import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/shared/theme.dart';

class StatsTable extends StatefulWidget {
  const StatsTable(this.character, {super.key});

  final Character character;

  @override
  State<StatsTable> createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Available Points
          Container(
            color: AppColors.secondaryColor,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(Icons.star,
                    color: widget.character.points > 0
                        ? Colors.yellow
                        : Colors.grey),
                const SizedBox(width: 20),
                const StyledText("Stat Points Available: "),
                const Expanded(child: SizedBox(width: 20)),
                //note we added widget.character, not character only,
                StyledHeading(widget.character.points.toString()),
              ],
            ),
          ),

          //Sats Table
          Table(
            children: widget.character.statsAtFormattedList.map((stat) {
              return TableRow(
                decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.5)),
                children: [
                  //Stat Title
                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: StyledHeading(stat['title']!),
                      )),

                  //Stat Value
                  TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: StyledHeading(stat['value']!),
                      )),

                  //Icon to Increae Stat
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: IconButton(
                      icon:
                          Icon(Icons.arrow_upward, color: AppColors.textColor),
                      onPressed: () {
                        setState(() {
                          widget.character.increaseStat(stat['title']!);
                        });
                      },
                    ),
                  ),

                  //Icon To Decrease Stat
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: IconButton(
                      icon: Icon(Icons.arrow_downward,
                          color: AppColors.textColor),
                      onPressed: () {
                        setState(() {
                          widget.character.decreaseStat(stat['title']!);
                        });
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
