import 'package:flutter/material.dart';
import 'package:gym_log/utils/helpers.dart';
import 'package:gym_log/utils/textStyles.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no_data.png',
            height: 180.0,
            width: 180.0,
          ),
          SizedBox(height: 14),
          Text(
            'No exercises yet!',
            style:
                isThemeDark(context) ? NoDataHeading.dark : NoDataHeading.light,
          ),
          Text(
            'click  +  to add the exercise',
            style: isThemeDark(context)
                ? NoDataSubtitle.dark
                : NoDataSubtitle.light,
          ),
        ],
      ),
    );
  }
}
