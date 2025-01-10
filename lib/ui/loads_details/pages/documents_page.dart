import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/ui/loads_details/loads_details_viewmodel.dart';
import 'package:lanaexpress/ui/loads_details/pages/details_page.dart';
import 'package:lanaexpress/ui/loads_details/pages/photo_page/rate_confirmation_list.dart';
import 'package:lanaexpress/ui/loads_details/upload_photo_view.dart';

@RoutePage()
final class DocumentsPage extends StatelessWidget {
  const DocumentsPage({required this.viewModel, super.key});
  final LoadsDetailsViewModel viewModel;

  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSizes.sizeM, 0, AppSizes.sizeM, 0),
          child: Column(
            children: <Widget>[
              DocumentsItemWidget(
                typeDocuments: 'PICK UP IMAGES',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (final BuildContext context) => UploadPhotoView(
                        loadsId: viewModel.currentLoads.id ?? 0,
                        typeFile: 'pick-up-images-files',
                        fileType: 'PICK UP IMAGES WITH BOL',
                        listPhoto: viewModel.pickUpList,
                      ),
                    ),
                  );
                },
                countFiles: viewModel.pickUpList.length,
              ),
              DocumentsItemWidget(
                typeDocuments: 'DELIVERY IMAGES',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (final BuildContext context) => UploadPhotoView(
                        loadsId: viewModel.currentLoads.id ?? 0,
                        typeFile: 'delivery-images-files',
                        fileType: 'DELIVERY',
                        listPhoto: viewModel.deliveryFilesList,
                      ),
                    ),
                  );
                },
                countFiles: viewModel.deliveryFilesList.length,
              ),
              DocumentsItemWidget(
                typeDocuments: 'POD DOCUMENTS',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (final BuildContext context) => RateConfirmationList(
                        loadsId: viewModel.currentLoads.id ?? 0,
                        typeFile: 'proof-of-delivery-files',
                        fileType: 'PROOF_OF_DELIVERY',
                        listPhoto: viewModel.lanaFilesList,
                      ),
                    ),
                  );
                },
                countFiles: viewModel.lanaFilesList.length,
              ),
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.sizeM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LoadStatusDropDown(
                    vm: viewModel,
                    loadsId: viewModel.currentLoads.id,
                  ),
                  const SizedBox(height: AppSizes.sizeXL),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

final class DocumentsItemWidget extends StatelessWidget {
  const DocumentsItemWidget({
    required this.typeDocuments,
    super.key,
    this.onTap, this.countFiles,
  });

  final String typeDocuments;
  final VoidCallback? onTap;
  final int? countFiles;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sizeM),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: AppSizes.size50,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: iconAdditionalColor,
            borderRadius: AppBordersRadius.borderRadiusAllXS,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  typeDocuments,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: whiteColor,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: whiteColor),
                    ),
                    child: Center(
                      child: Text(
                        countFiles.toString(),
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: whiteColor,
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
