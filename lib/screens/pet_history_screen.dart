import 'package:FurEverHome/cubit/fur_ever_home_cubit.dart';
import 'package:FurEverHome/helpers/widgets_and_attributes.dart';
import 'package:FurEverHome/utils/app_colors.dart';
import 'package:FurEverHome/utils/constants.dart';
import 'package:FurEverHome/widgets/pet_view_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetHistoryScreen extends StatefulWidget {
  const PetHistoryScreen({super.key});

  @override
  State<PetHistoryScreen> createState() => _PetHistoryScreenState();
}

class _PetHistoryScreenState extends State<PetHistoryScreen> {
  late final FurEverHomeCubit _furEverHomeCubit;

  @override
  void initState() {
    _furEverHomeCubit = context.read<FurEverHomeCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            const Text(
              "Adopted Pets",
              style: TextStyle(
                color: Colors.white,
                fontFamily: Constants.FONT_FAMILY_FOLDIT,
                fontSize: 36,
                decoration: TextDecoration.underline,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _furEverHomeCubit.petAlreadyAdoptedList.isEmpty
                      ? 1
                      : _furEverHomeCubit.petAlreadyAdoptedList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocBuilder<FurEverHomeCubit, FurEverHomeState>(
                          builder: (context, state) {
                            if (state is FurEverHomeLoading ||
                                _furEverHomeCubit
                                    .petAlreadyAdoptedList.isEmpty) {
                              return const Center(
                                child: CupertinoActivityIndicator(
                                    radius: 50.0,
                                    color: CupertinoColors.activeBlue),
                              );
                            }
                            return BlocProvider.value(
                              value: _furEverHomeCubit,
                              child: PetViewCard(
                                petForAdoption: _furEverHomeCubit
                                    .petAlreadyAdoptedList[index],
                              ),
                            );
                          },
                        ),
                        sizedBoxH30
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
