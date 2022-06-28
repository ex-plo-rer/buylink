import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import 'map_search_dialog.dart';

class MapSearchTermContainer extends StatelessWidget {
  const MapSearchTermContainer({
    Key? key,
    required this.searchTerm,
    required this.onMinChanged,
    required this.onMaxChanged,
    required this.onSliderChanged,
    required this.sliderValue,
    required this.onApplyPressed,
    this.hideFilter = false,
    this.marginTop = 40,
    this.horizontalMargin = 10,
    this.containerColor = AppColors.light,
  }) : super(key: key);
  final String searchTerm;
  final void Function(String)? onMinChanged;
  final void Function(String)? onMaxChanged;
  final void Function(double)? onSliderChanged;
  final double sliderValue;
  final void Function()? onApplyPressed;
  final bool hideFilter;
  final double marginTop;
  final double horizontalMargin;
  final Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin:
          EdgeInsets.fromLTRB(horizontalMargin, marginTop, horizontalMargin, 0),
      padding: const EdgeInsets.fromLTRB(4, 10, 13, 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        color: containerColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              size: 12,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacing.smallWidth(),
          Expanded(child: Text(searchTerm)),
          hideFilter ? Container() : const Spacing.mediumWidth(),
          hideFilter
              ? Container()
              : Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.shade1,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MapSearchDialog(
                            onMinChanged: onMinChanged,
                            onMaxChanged: onMaxChanged,
                            onSliderChanged: onSliderChanged,
                            value: sliderValue,
                            onApplyPressed: onApplyPressed,
                          );
                        },
                      );
                    },
                    child: Image.asset("assets/images/filter.png"),
                  ),
                ),
        ],
      ),
    );
  }
}
