import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/domain/models/loadboard_model.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_box.dart';
import 'package:lanaexpress/ui/loadboard/loadboard_viewmodel.dart';
import 'package:lanaexpress/utils/base_button.dart';
import 'package:lanaexpress/utils/filter_loadboards_button.dart';
import 'package:lanaexpress/utils/title_widget.dart';

final class LoadBoardScreen extends StatefulWidget {
  const LoadBoardScreen({required this.vm, super.key});
  final LoadboardViewModel vm;

  @override
  State<LoadBoardScreen> createState() => _LoadBoardScreenState();
}

class _LoadBoardScreenState extends State<LoadBoardScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() async {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !widget.vm.isLoading) {
      // Прокрутили до кінця списку і не завантажуємо вже додаткові дані
      await widget.vm.loadMoreData();
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeM),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const TitleWidget(
                title: NavBarTitles.loadboard,
              ),
              FilterLoadbordsButton(
                viewModel: widget.vm,
              ),
            ],
          ),
          widget.vm.loadboards!.isNotEmpty
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppSizes.size12),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: widget.vm.loadboards?.length,
                      itemBuilder:
                          (final BuildContext context, final int index) {
                        if (index == widget.vm.loadboards!.length - 1) {
                          // Останній елемент списку, можливо, відобразити індикатор завантаження
                          return widget.vm.isLoading
                              ? const CircularProgressIndicator()
                              : LoadBoardBox(
                                  viewModel: widget.vm,
                                  loadboard: widget.vm.loadboards![index],
                                );
                        } else {
                          return LoadBoardBox(
                            viewModel: widget.vm,
                            loadboard: widget.vm.loadboards![index],
                          );
                        }
                        // LoadBoardBox(
                        //   viewModel: widget.vm,
                        //   loadboard: widget.vm.loadboards![index],
                        // );
                      },
                    ),
                  ),
                )
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(AssetsIcons.loadboardEmpty),
                      const Gap(55),
                      Text(
                        'No data for now',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(AppSizes.sizeM),
                      BaseButton(
                        title: 'Refresh',
                        onPressed: () {
                          widget.vm.refreshLoadboard();
                        },
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class DriverIdWidget extends StatelessWidget {
  const DriverIdWidget({
    super.key,
    this.iValue,
    this.dValue,
  });
  final DriversList? iValue;
  final String? dValue;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.size6),
      child: Container(
        width: 46,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: mainPrimaryColor),
          borderRadius: AppBordersRadius.borderRadiusAllXS,
          color: grey2,
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                '#${iValue?.driverId}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 14,
                    ),
              ),
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    '${iValue?.miles}m',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
