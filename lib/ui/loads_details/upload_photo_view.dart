import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/data/managers/permission_manager/permission_type.dart';
import 'package:lanaexpress/data/managers/permission_manager/request_permission_manager.dart';
import 'package:lanaexpress/domain/models/lana_files.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:lanaexpress/ui/loads_details/full_screen.dart';
import 'package:lanaexpress/ui/loads_details/loads_details_viewmodel.dart';
import 'package:lanaexpress/ui/loads_details/pdf_view.dart';
import 'package:lanaexpress/ui/profile/task_view/upload_photo.dart';
import 'package:lanaexpress/utils/base_outlined_button.dart';
import 'package:lanaexpress/utils/check_file_type.dart';
import 'package:lanaexpress/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
final class UploadPhotoView extends StatelessWidget {
  const UploadPhotoView({
    required this.loadsId,
    required this.typeFile,
    required this.fileType,
    required this.listPhoto,
    super.key,
  });
  final int loadsId;
  final String typeFile;
  final String fileType;
  final List<LanaFiles> listPhoto;

  @override
  Widget build(final BuildContext context) {
    return ViewModelBuilder<LoadsDetailsViewModel>.reactive(
      viewModelBuilder: () => LoadsDetailsViewModel(),
      //onViewModelReady: (final LoadsDetailsViewModel viewModel) {},
      builder: (
        final BuildContext context,
        final LoadsDetailsViewModel viewModel,
        final Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.sizeM,
              vertical: AppSizes.sizeM,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                UploadPhotoWidget(
                  onTap: () async {
                    RequestPermissionManager(PermissionType.camera)
                        .onPermissionDenied(() {})
                        .onPermissionGranted(() {})
                        .onPermissionPermanentlyDenied(() {})
                        .execute();
                    await showDialog(
                      context: context,
                      builder: (final BuildContext context) {
                        return AlertDialog(
                          elevation: 0,
                          backgroundColor: whiteColor,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              BaseOutlinedButton(
                                onPressed: () async {
                                  await viewModel.openImagePicker(
                                    false,
                                    fileType,
                                    loadsId,
                                    listPhoto,
                                  );
                                  AppRouter().maybePop();
                                },
                                title: ImagePikerType.gallery,
                              ),
                              const Gap(AppSizes.sizeM),
                              BaseOutlinedButton(
                                onPressed: () async {
                                  await viewModel.openImagePicker(
                                    true,
                                    fileType,
                                    loadsId,
                                    listPhoto,
                                  );
                                  AppRouter().maybePop();
                                },
                                title: ImagePikerType.camera,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  title: uploadPhotoOrDocuments,
                  subtitle: 'Click here to upload',
                ),
                viewModel.isBusy
                    ? const CircularProgressIndicator()
                    : Flexible(
                        child: GridView.builder(
                          padding: const EdgeInsets.only(top: AppSizes.sizeSSM),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: listPhoto.length,
                          itemBuilder: (
                            final BuildContext context,
                            final int index,
                          ) {
                            final LanaFiles file = listPhoto[index];
                            return listPhoto[index].filename != null
                                ? Padding(
                                    padding: const EdgeInsets.all(
                                      AppSizes.sizeS,
                                    ),
                                    child: PhotoItemWidget(
                                      image:
                                          'https://tms.lana.express/uploads/${file.url}',
                                      viewModel: viewModel,
                                      photoObject: file,
                                      fileTypePhoto: fileType,
                                      loadsId: loadsId,
                                      listLanaFiles: listPhoto,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(
                                      AppSizes.sizeS,
                                    ),
                                    child: PhotoItemWidget(
                                      image: file.url,
                                      viewModel: viewModel,
                                      photoObject: file,
                                      fileTypePhoto: fileType,
                                      loadsId: loadsId,
                                      listLanaFiles: listPhoto,
                                    ),
                                  );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showAlertDialog(final BuildContext context) =>
      showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (final BuildContext context) => CupertinoAlertDialog(
          title: const Text('Permission Denied'),
          content: const Text('Allow access to gallery and photos'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => openAppSettings(),
              child: const Text('Settings'),
            ),
          ],
        ),
      );
}

final class PhotoItemWidget extends StatefulWidget {
  const PhotoItemWidget({
    required this.image,
    required this.viewModel,
    required this.fileTypePhoto,
    required this.loadsId,
    required this.listLanaFiles, super.key,
    this.photoObject,
  });
  final LoadsDetailsViewModel viewModel;
  final String? image;
  final LanaFiles? photoObject;
  final String fileTypePhoto;
  final int loadsId;
  final List<LanaFiles> listLanaFiles;

  @override
  State<PhotoItemWidget> createState() => _PhotoItemWidgetState();
}

class _PhotoItemWidgetState extends State<PhotoItemWidget> {
  String _fileType = '';

  @override
  void initState() {
    super.initState();
    _getFileData();
  }

  void _getFileData() async {
    final String fileType = await checkFileType(File(widget.image ?? ''));
    setState(() {
      _fileType = fileType;
    });
  }

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.image != null && _fileType == 'JPG') {
          Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (final BuildContext context) =>
                  FullScreenPhotoWidget(src: File(widget.image ?? '')),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (final BuildContext context) =>
                  PdfView(src: File(widget.image ?? '')),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: grey2),
          borderRadius: AppBordersRadius.borderRadiusAllVL,
        ),
        child: Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipRRect(
                borderRadius: AppBordersRadius.borderRadiusAllVL,
                child: _fileType == 'JPG'
                    ? containsSymbol(widget.image)
                        ? Image.network(
                            File(widget.image ?? '').path,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            File(widget.image ?? '').path,
                            fit: BoxFit.cover,
                          )
                    : Center(
                        child: Text(
                          'pdf',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: dark),
                        ),
                      ),
              ),
            ),
            Positioned(
              right: 0,
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (widget.image != null) {
                    widget.viewModel.deleteImages(
                      widget.loadsId,
                      widget.photoObject?.id ?? 0,
                      widget.fileTypePhoto,
                      widget.listLanaFiles,
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    color: Colors.white,
                    child: const Icon(
                      CupertinoIcons.clear_circled_solid,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
