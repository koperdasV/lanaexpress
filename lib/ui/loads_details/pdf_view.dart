// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/utils/base_button.dart';
import 'package:path_provider/path_provider.dart';

final class PdfView extends StatefulWidget {
  final File src;
  const PdfView({
    required this.src,
    final Key? key,
  }) : super(key: key);

  @override
  State<PdfView> createState() => PdfViewState();
}

class PdfViewState extends State<PdfView> {
  String remotePDFpath = '';
  bool isReady = true;

  @override
  void initState() {
    super.initState();
    remotePDFpath = widget.src.path;
    createFileOfPdfUrl().then((final File f) {
      setState(() {
        remotePDFpath = f.path;
        isReady = false;
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    final Completer<File> completer = Completer<File>();
    try {
      final String url = widget.src.path;
      final String filename = url.substring(url.lastIndexOf("/") + 1);
      final HttpClientRequest request =
          await HttpClient().getUrl(Uri.parse(url));
      final HttpClientResponse response = await request.close();
      final Uint8List bytes =
          await consolidateHttpClientResponseBytes(response);
      final Directory dir = await getApplicationDocumentsDirectory();
      final File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Builder(
          builder: (final BuildContext context) {
            return isReady
                ? const CircularProgressIndicator()
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.sizeM,
                      ),
                      child: BaseButton(
                        title: "Open PDF",
                        onPressed: () async {
                          if (remotePDFpath.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (final BuildContext context) =>
                                    PDFScreen(path: remotePDFpath),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

final class PDFScreen extends StatefulWidget {
  final String? path;

  const PDFScreen({final Key? key, this.path}) : super(key: key);

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            onRender: (int? pages) {
              setState(() {
                pages = pages;
                isReady = true;
              });
            },
            onError: (final dynamic error) {
              setState(() {
                errorMessage = error.toString();
              });
              if (kDebugMode) {
                print(error.toString());
              }
            },
            onPageError: (final int? page, final dynamic error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              if (kDebugMode) {
                print('$page: ${error.toString()}');
              }
            },
            onViewCreated: (final PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (final String? uri) {
              if (kDebugMode) {
                print('goto uri: $uri');
              }
            },
            onPageChanged: (final int? page, final int? total) {
              if (kDebugMode) {
                print('page change: $page/$total');
              }
              setState(() {
                currentPage = page;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (
          final BuildContext context,
          final AsyncSnapshot<PDFViewController> snapshot,
        ) {
          if (snapshot.hasData) {
            return FloatingActionButton(
              backgroundColor: mainPrimaryColor,
              child: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () async {
                await snapshot.data?.setPage(pages! + 1);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
