import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/ui/main/main_viewmodel.dart';

final class HoldWidget extends StatelessWidget {
  const HoldWidget({
    required this.vm,
    super.key,
  });

  final MainViewModel vm;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: 100,
      child: ListView.builder(
        shrinkWrap: true,
        physics: (vm.blockedUnitsList?.length ?? 0) < 3
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        itemCount: vm.blockedUnitsList?.length,
        itemBuilder: (final BuildContext context, final int index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: AppSizes.size12),
                  width: 100,
                  constraints: const BoxConstraints(
                    maxHeight: 20.0 * 3,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 1.5),
                    borderRadius: AppBordersRadius.borderRadiusAllVL,
                  ),
                  child: Text(
                    vm.blockedUnitsList?[index].holdMessage ?? 'HOLD - #',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 12,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  top: -4,
                  child: Container(
                    width: 70,
                    height: 20,
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSizes.size6),
                    color: background,
                    child: Center(
                      child: Text(
                        '${vm.blockedUnitsList?[index].holdTime ?? 'time'}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontSize: 14,
                              color: mainPrimaryColor,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
