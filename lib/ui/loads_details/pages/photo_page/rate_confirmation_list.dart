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
import 'package:lanaexpress/ui/loads_details/loads_details_viewmodel.dart';
import 'package:lanaexpress/ui/loads_details/upload_photo_view.dart';
import 'package:lanaexpress/ui/profile/task_view/upload_photo.dart';
import 'package:lanaexpress/utils/base_outlined_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

final class RateConfirmationList extends StatelessWidget {
  const RateConfirmationList({
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
          appBar: AppBar(),
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