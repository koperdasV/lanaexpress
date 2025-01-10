import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/ui/profile/components/profile_task.dart';
import 'package:lanaexpress/ui/profile/profile_viewmodel.dart';
import 'package:lanaexpress/ui/profile/task_view/task_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.viewModel, super.key});
  final ProfileViewModel viewModel;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 40),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Text(
          //         NavBarTitles.profile,
          //         style: Theme.of(context).textTheme.labelLarge,
          //       ),

          //     ],
          //   ),
          // ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(AssetsIcons.loadsEmpty),
                const Gap(55),
                Text(
                  'The screen is under development',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(AppSizes.sizeM),
                SizedBox(
                  height: 46,
                  child: OutlinedButton(
                    onPressed: () {
                      viewModel.logout(context);
                    },
                    style: ButtonStyle(
                      padding:
                          const MaterialStatePropertyAll(EdgeInsets.all(10)),
                      backgroundColor:
                          const MaterialStatePropertyAll(btnFilter),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: AppBordersRadius.borderRadiusAllS,
                          side: BorderSide(
                            color: mainPrimaryColor,
                            width: 15,
                          ),
                        ),
                      ),
                      side: MaterialStateProperty.all(
                        const BorderSide(
                          color: mainPrimaryColor,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Logout',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Gap(7),
                        Image.asset(AssetsIcons.icLogout),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
          // Expanded(
          //   child: ListView(
          //     shrinkWrap: true,
          //     children: <Widget>[
          //       ProfileTask(
          //         task: 'Task #1',
          //         textButton: 'Completed',
          //         title: 'Complete vehicle information',
          //         subtitle: 'Let us kow more information about your vehicle.',
          //         color: mainPrimaryColor,
          //         onPressed: () {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (final BuildContext context) =>
          //                   const TaskView(),
          //             ),
          //           );
          //         },
          //       ),
          //       ProfileTask(
          //         task: 'Task #2',
          //         textButton: 'Not Completed',
          //         title: 'Upload vehicle registration',
          //         subtitle:
          //             'We require vehicle registration to be uploaded before you can search for loads.',
          //         widthBtn: 166,
          //         color: mainSecondaryColor,
          //         onPressed: () {},
          //       ),
          //       ProfileTask(
          //         task: 'Task #3',
          //         textButton: 'Failed',
          //         title: 'Upload  insurance Certificate',
          //         subtitle:
          //             'We require all contractors to have their own insurance for physical, cargo, and liability.',
          //         widthBtn: 90,
          //         color: mainAdditionalColor,
          //         onPressed: () {},
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
