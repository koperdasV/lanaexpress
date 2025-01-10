import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:responsive_builder/responsive_builder.dart';

Future<void> showColoredToast(
  final String msg, {
  final Color textColor = whiteColor,
}) async {
  await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    webPosition: "left",
    textColor: whiteColor,
    fontSize: 18,
    backgroundColor: grey,
    timeInSecForIosWeb: 5,
  );
}

DialogRoute<dynamic> myCustomDialogRoute({
  required final String title,
  required final String text,
  final String buttonText = "Ok",
  final VoidCallback? onPressed,
}) {
  return DialogRoute<dynamic>(
    context: GoogleMapsApiKey.globalNavigatorKey.currentContext!,
    barrierDismissible: false,
    builder: (final BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: onPressed ??
                () {
                  Navigator.of(context).pop();
                },
            child: Text(buttonText),
          ),
        ],
      );
    },
  );
}

dynamic toastCheck(final String text,
    {final ToastGravity gravity = ToastGravity.BOTTOM,
    final Color backgroundColor = mainPrimaryColor,}) {
  return Fluttertoast.showToast(
    msg: text,
    textColor: whiteColor,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    fontSize: 16.0,
  );
}

Future<void> futureDelayedFunc({final int milliseconds = 1000}) async {
  await Future<dynamic>.delayed(Duration(milliseconds: milliseconds));
}

void showAlert(
  final BuildContext context,
  final String title,
  final VoidCallback onOk, {
  final VoidCallback? onCancel,
  final Widget? content,
  final String? okTitle,
  final String? cancelTitle,
  final bool isShowOk = true,
  final bool isPadding = true,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (final BuildContext context) {
      return ResponsiveBuilder(
        builder: (final BuildContext context,
                final SizingInformation sizingInformation,) =>
            AlertDialog(
          backgroundColor: background,
          contentPadding: EdgeInsets.zero,
          content: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            width: sizingInformation.isTablet || sizingInformation.isMobile
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width / 2.5,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: customScrollbarView(
              isPadding: isPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  content ?? const Offstage(),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Offstage(),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: MaterialButton(
                              elevation: 0,
                              focusElevation: 0,
                              highlightElevation: 0,
                              disabledElevation: 0,
                              hoverElevation: 0,
                              onPressed: () {
                                AppRouter().maybePop();
                                if (onCancel != null) {
                                  onCancel();
                                }
                              },
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    AppBordersRadius.borderRadiusAllXS,
                              ),
                              child: Text(
                                cancelTitle ?? 'cancel',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        isShowOk ? const SizedBox(width: 20) : const Offstage(),
                        isShowOk
                            ? Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: MaterialButton(
                                    elevation: 0,
                                    focusElevation: 0,
                                    hoverElevation: 0,
                                    disabledElevation: 0,
                                    highlightElevation: 0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          AppBordersRadius.borderRadiusAllXS,
                                    ),
                                    onPressed: onOk,
                                    child: Text(
                                      okTitle ?? 'Save',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: whiteColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Offstage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget customScrollbarView({
  final ScrollController? controller,
  final Widget? child,
  final bool isPadding = true,
  final bool isMobile = false,
}) {
  return ScrollConfiguration(
    behavior: Behavior().copyWith(scrollbars: false),
    child: isMobile
        ? SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: child,
            ),
          )
        : CupertinoScrollbar(
            controller: controller,
            thickness: 5,
            child: Padding(
              padding: isPadding
                  ? const EdgeInsets.only(right: 16)
                  : EdgeInsets.zero,
              child: SingleChildScrollView(
                controller: controller,
                child: child,
              ),
            ),
          ),
  );
}

Widget customDetailView({
  required final BuildContext context,
  final Widget? items,
}) {
  return Container(
    width: 400,
    height: double.infinity,
    margin: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    child: items,
  );
}

class Behavior extends ScrollBehavior {
  Widget buildViewportChrome(
    final BuildContext context,
    final Widget child,
    final AxisDirection axisDirection,
  ) {
    return child;
  }
}

String? combineLocation(
    final String? city, final String? state, final String? zipCode,) {
  // Використовуйте оператор конкатенації
  final String fullLocation = '${city ?? ''}, ${state ?? ''} ${zipCode ?? ''}';

  // Або використовуйте метод join
  //String fullLocation = [city, state, zipCode].join(', ');

  return fullLocation;
}

const String checkSymbol = 'https://tms.lana.express/uploads/';

bool containsSymbol(final String? image) {
  final bool containsSymbol = image?.contains(checkSymbol) ?? false;
  if (containsSymbol) {
    return true;
  }
  return false;
}

Future<Uint8List?> compressFile(final File file) async {
  final Uint8List? result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    quality: 70,
  );
  return result;
}

String? vehicalType(final String? vehicleType) {
  if (vehicleType == 'TYPE_CARGO') {
    return 'Cargo';
  } else if (vehicleType == 'SMALL_CARGO') {
    return 'Small Cargo';
  }
  return '';
}
