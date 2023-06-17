import 'package:FurEverHome/cubit/fur_ever_home_cubit.dart';
import 'package:FurEverHome/helpers/widgets_and_attributes.dart';
import 'package:FurEverHome/models/pet.dart';
import 'package:FurEverHome/screens/pet_details_screen.dart';
import 'package:FurEverHome/utils/app_colors.dart';
import 'package:FurEverHome/utils/constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetViewCard extends StatelessWidget {
  final Pet petForAdoption;
  const PetViewCard({super.key, required this.petForAdoption});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.0),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => PetDetailsScreen(
              petForAdoption: petForAdoption,
            ),
          ),
        );
      },
      child: BlocBuilder<FurEverHomeCubit, FurEverHomeState>(
        builder: (context, state) {
          return Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: AppColors.cardColor,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 240,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            _petImageWidget(),
                            sizedBoxW30,
                            Expanded(child: _petInformationWidget())
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              petForAdoption.adopted ?? false
                  ? Positioned(
                      left: -24,
                      top: 24,
                      child: buildBadge(
                          turns: const AlwaysStoppedAnimation(-45 / 360)))
                  : const SizedBox.shrink()
            ],
          );
        },
      ),
    );
  }

  Widget _petImageWidget() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: ExtendedImage.network(
        petForAdoption.images[0],
        height: 120,
        width: 120,
        printError: false,
        loadStateChanged: (ExtendedImageState state) {
          if (state.extendedImageLoadState == LoadState.completed) {
            return state.completedWidget;
          } else {
            return const Padding(
              padding: EdgeInsets.all(12),
              child: CupertinoActivityIndicator(
                  radius: 20.0, color: CupertinoColors.activeBlue),
            );
          }
        },
      ),
    );
  }

  Widget _petInformationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              petForAdoption.name,
              style: const TextStyle(
                  fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor),
            ),
            petForAdoption.gender == Gender.MALE
                ? const Icon(
                    Icons.male_rounded,
                    color: AppColors.maleColor,
                    size: 48,
                  )
                : const Icon(
                    Icons.female_outlined,
                    color: AppColors.femaleColor,
                    size: 48,
                  )
          ],
        ),
        sizedBoxH16,
        Text(
          petForAdoption.species,
          style: const TextStyle(
              fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.lightTextColor),
        ),
        sizedBoxH16,
        Text(
          "${petForAdoption.age} year's old",
          style: const TextStyle(
              fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.lightTextColor),
        ),
        sizedBoxH40,
        Text(
          "Price : \$${petForAdoption.price}",
          style: const TextStyle(
              fontFamily: Constants.FONT_FAMILY_PLUS_JAKARTA_SANS,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xff5DC6AD)),
        ),
      ],
    );
  }

  Widget buildBadge({required Animation<double> turns}) {
    return RotationTransition(
      turns: turns,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 30),
        color: AppColors.bannerColor,
        child: const Text(
          'Adopted',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
