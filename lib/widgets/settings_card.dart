import 'package:flutter/material.dart';
import 'package:gym_log/utils/colors.dart';
import 'package:gym_log/utils/helpers.dart';
import 'package:gym_log/utils/textStyles.dart';

class SettingsCard extends StatelessWidget {
  final Widget child;
  final String title;
  // final String subTitle;

  const SettingsCard({this.child, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Material(
        elevation: 3,
        color: isThemeDark(context)
            ? getOverLayColor(context, MyColors.darkGrey)
            : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isThemeDark(context)
                      ? SettingsHeadingStyle.dark
                      : SettingsHeadingStyle.light,
                ),
                SizedBox(height: 12.0),
                // Text(subTitle),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
