import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/data/managers/permission_manager/permission_type.dart';
import 'package:lanaexpress/data/managers/permission_manager/request_permission_manager.dart';
import 'package:lanaexpress/generated/router.dart';
import 'package:lanaexpress/ui/profile/profile_viewmodel.dart';
import 'package:lanaexpress/ui/profile/task_view/upload_photo.dart';
import 'package:lanaexpress/utils/base_button.dart';
import 'package:lanaexpress/utils/base_outlined_button.dart';
import 'package:stacked/stacked.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onViewModelReady: (viewModel) {},
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 26),
                    child: Text(
                      ProfileTiles.taskName,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  viewModel.imageFiles.isEmpty
                      ? UploadPhotoWidget(
                          onTap: () {
                            RequestPermissionManager(PermissionType.camera)
                                .onPermissionDenied(() {
                              if (kDebugMode) {
                                print('Camera permission denied');
                              }
                            }).onPermissionGranted(() {
                              if (kDebugMode) {
                                print('Camera permission granted');
                              }
                            }).onPermissionPermanentlyDenied(() {
                              if (kDebugMode) {
                                print('Camera permission permanently denied');
                              }
                            }).execute();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      BaseOutlinedButton(
                                        onPressed: () async {
                                          await viewModel
                                              .openImagePicker(false);
                                          router.pop();
                                        },
                                        title: ImagePikerType.gallery,
                                      ),
                                      const Gap(AppSizes.sizeM),
                                      BaseOutlinedButton(
                                        onPressed: () async {
                                          await viewModel.openImagePicker(true);
                                          router.pop();
                                        },
                                        title: ImagePikerType.camera,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          title: ProfileTiles.uploadPhoto,
                          subtitle:
                              ProfileTiles.clickHere,
                        )
                      : Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ClipRRect(
                                borderRadius:
                                    AppBordersRadius.borderRadiusAllVL,
                                child: Image.file(
                                  viewModel.imageFiles.first,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  viewModel
                                      .deleteImages(viewModel.imageFiles.first);
                                },
                                child: const Icon(
                                  CupertinoIcons.clear_circled_solid,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    child: Text(
                      'Make sure your vehicle registration',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: dark),
                    ),
                  ),
                  const Column(
                    children: [
                      InfoItemWidget(
                        title: 'Is current(not expired)',
                      ),
                      InfoItemWidget(
                        title: 'Is not blurry',
                      ),
                      InfoItemWidget(
                        title: 'Includes all four corners of the card',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: BaseButton(
                      title: save,
                      onPressed: () {
                        // відправка фото на сервер
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class InfoItemWidget extends StatelessWidget {
  const InfoItemWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.check_mark,
            color: mainPrimaryColor,
          ),
          const Gap(AppSizes.sizeS),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
