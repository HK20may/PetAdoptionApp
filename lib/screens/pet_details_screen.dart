import 'dart:ui';

import 'package:FurEverHome/cubit/fur_ever_home_cubit.dart';
import 'package:FurEverHome/helpers/widgets_and_attributes.dart';
import 'package:FurEverHome/models/pet.dart';
import 'package:FurEverHome/utils/app_colors.dart';
import 'package:FurEverHome/utils/constants.dart';
import 'package:FurEverHome/utils/toast.dart';
import 'package:FurEverHome/widgets/pet_details_images_widget.dart';
import 'package:FurEverHome/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetDetailsScreen extends StatefulWidget {
  final Pet petForAdoption;
  const PetDetailsScreen({super.key, required this.petForAdoption});

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBgColor,
      appBar: _appBar(),
      body: _buildBody(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<FurEverHomeCubit, FurEverHomeState>(
            builder: (context, state) {
              return PrimaryButton(
                "Adopt this Cutie",
                isLoading: state is FurEverHomeLoading,
                isActive: !(widget.petForAdoption.adopted ?? true),
                onPressed: () {
                  if ((widget.petForAdoption.adopted ?? true)) {
                    Toast.info("Already Adopted");
                  } else {
                    context
                        .read<FurEverHomeCubit>()
                        .adoptThePet(widget.petForAdoption);
                    Toast.normal(
                        "YaYa you have adopted ${widget.petForAdoption.name}");
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: AppColors.cardColor,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
      centerTitle: false,
      title: const Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Text(
          "Adopt this...",
          style: TextStyle(
              fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: PetDetailsImageWidget(petForAdoption: widget.petForAdoption),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.5,
          builder: (context, controller) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.primaryBgColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: ListView.builder(
                itemCount: 1,
                controller: controller,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _petDetailsBottomSheet();
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _petDetailsBottomSheet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        sizedBoxH12,
        _detailsWidget(
            title1: "Name :",
            subTitle1: widget.petForAdoption.name,
            title2: "Specie :",
            subTitle2: widget.petForAdoption.species),
        const Divider(
          thickness: 1.5,
          color: Colors.white30,
        ),
        _detailsWidget(
            title1: "Price:",
            subTitle1: "\$${widget.petForAdoption.price}",
            title2: "Gender :",
            subTitle2: widget.petForAdoption.gender.name),
        const Divider(
          thickness: 1.5,
          color: Colors.white30,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Text(
            "Description : ",
            style: TextStyle(
                fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.lightTextColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.petForAdoption.description,
            style: const TextStyle(
                fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor),
          ),
        ),
      ],
    );
  }

  Widget _detailsWidget(
      {required title1,
      required String subTitle1,
      required String title2,
      required String subTitle2}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: const TextStyle(
                      fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightTextColor),
                ),
                sizedBoxH12,
                Text(
                  subTitle1,
                  style: const TextStyle(
                      fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor),
                ),
              ],
            ),
            const VerticalDivider(
              thickness: 1.5,
              color: Colors.white30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title2,
                  style: const TextStyle(
                      fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightTextColor),
                ),
                sizedBoxH12,
                Text(
                  subTitle2,
                  style: const TextStyle(
                      fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
