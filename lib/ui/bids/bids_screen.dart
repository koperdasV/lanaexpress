import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/ui/bids/bids_viewmodel.dart';
import 'package:lanaexpress/ui/notification/components/notification_item.dart';

final class BidsScreen extends StatefulWidget {
  const BidsScreen({required this.viewModel, super.key});
  final BidsViewModel viewModel;

  @override
  State<BidsScreen> createState() => _BidsScreenState();
}

class _BidsScreenState extends State<BidsScreen> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: widget.viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.sizeM,
                vertical: AppSizes.sizeS,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: (widget.viewModel.notifications?.isEmpty ?? false)
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(AssetsIcons.loadsEmpty),
                                const Text("Waiting for notifications..."),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount:
                                widget.viewModel.notifications?.length ?? 0,
                            itemBuilder:
                                (final BuildContext context, final int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSizes.sizeM,
                                ),
                                child: NotificationItem(
                                  title: 'Bids',
                                  subtitle:
                                      'Message: ${widget.viewModel.notifications?[index]}',
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
