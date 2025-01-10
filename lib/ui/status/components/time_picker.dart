import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/ui/status/status_viewmodel.dart';

final class TimePicker extends StatefulWidget {
  const TimePicker({
    required this.viewModel, super.key,
  });

  final StatusViewModel viewModel;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  DateTime selectedTime = DateTime.now();
  @override
  Widget build(final BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              time,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            TextFormField(
              controller: widget.viewModel.timeController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 8.0,
                ),
                hintText: 'H:m',
              ),
              readOnly: true,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (final BuildContext context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 200,
                          color: Colors.white,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: selectedTime,
                            onDateTimeChanged: (final DateTime newTime) {
                              selectedTime = newTime;
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: CupertinoButton(
                            child: Text(
                              'Select',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontSize: 24,
                                  ),
                            ),
                            onPressed: () {
                              setState(() {
                                widget.viewModel.timeController.text =
                                    DateFormat('HH:mm:ss').format(selectedTime);
                              });

                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
