import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';
import 'package:lanaexpress/constants/icons.dart';
import 'package:lanaexpress/constants/strings.dart';
import 'package:lanaexpress/ui/login/components/login_text_field.dart';
import 'package:lanaexpress/ui/login/login_view_model.dart';
import 'package:lanaexpress/utils/base_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.vm, super.key});
  final LoginViewModel vm;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;
  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                const Gap(AppSizes.size40),
                Image.asset(AssetsIcons.logo),
                const Gap(82),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSizes.sizeM),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: backgroundLight,
                      borderRadius: AppBordersRadius.borderRadiusAllSSM,
                    ),
                    child: Form(
                      key: widget.vm.emailFormKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.sizeL,),
                            child: Text(
                              login,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          LoginTextFormField(
                            controller: widget.vm.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: widget.vm.emailValidator,
                            label: email,
                          ),
                          const Gap(AppSizes.sizeM),
                          LoginTextFormField(
                            label: password,
                            controller: widget.vm.passwordController,
                            obscureText: isVisible,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: isVisible
                                  ? Image.asset(AssetsIcons.icNotVisible)
                                  : Image.asset(AssetsIcons.icVisible),
                            ),
                          ),
                          const Gap(8),
                          Padding(
                            padding: const EdgeInsets.all(AppSizes.sizeL),
                            child: BaseButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (widget.vm.emailFormKey.currentState !=
                                        null &&
                                    widget.vm.emailFormKey.currentState!
                                        .validate()) {
                                  widget.vm.login(
                                      widget.vm.emailController.text,
                                      widget.vm.passwordController.text,);
                                }
                              },
                              title: login,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
