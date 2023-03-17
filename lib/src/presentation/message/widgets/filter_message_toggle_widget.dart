import 'package:flutter/material.dart';

import '../../../core/enum/message_filters.dart';
import '../../../presentation/widgets/app_chip.dart';

class FilterMessageToggleWidget extends StatelessWidget {
  const FilterMessageToggleWidget({Key? key, required this.valueNotifier})
      : super(key: key);
  final ValueNotifier<FilterMessage> valueNotifier;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FilterMessage>(
        valueListenable: valueNotifier,
        builder: (context, value, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                AppMaterialYouChip(
                  title: FilterMessage.daily.name(context),
                  isSelected: FilterMessage.daily == value,
                  onPressed: () => valueNotifier.value = FilterMessage.daily,
                ),
                AppMaterialYouChip(
                  title: FilterMessage.weekly.name(context),
                  isSelected: FilterMessage.weekly == value,
                  onPressed: () => valueNotifier.value = FilterMessage.weekly,
                ),
                AppMaterialYouChip(
                  title: FilterMessage.monthly.name(context),
                  isSelected: FilterMessage.monthly == value,
                  onPressed: () => valueNotifier.value = FilterMessage.monthly,
                ),
                AppMaterialYouChip(
                  title: FilterMessage.yearly.name(context),
                  isSelected: FilterMessage.yearly == value,
                  onPressed: () => valueNotifier.value = FilterMessage.yearly,
                ),
                AppMaterialYouChip(
                  title: FilterMessage.all.name(context),
                  isSelected: FilterMessage.all == value,
                  onPressed: () => valueNotifier.value = FilterMessage.all,
                ),
              ],
            ),
          );
        });
  }
}
