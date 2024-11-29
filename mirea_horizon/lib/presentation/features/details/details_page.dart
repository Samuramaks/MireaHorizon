import 'package:flutter/widgets.dart';

import '../widgets/custom_widget.dart';

class DetailsScreen extends StatelessWidget {
  final String nameTitle;
  DetailsScreen({super.key, required this.nameTitle});
  @override
  Widget build(BuildContext context) {
    return CustomWidget(
        nameAppBar: nameTitle,
        body: Center(
          child: Text(nameTitle),
        ));
  }
}
