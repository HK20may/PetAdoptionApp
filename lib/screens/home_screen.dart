import 'package:FurEverHome/cubit/fur_ever_home_cubit.dart';
import 'package:FurEverHome/helpers/widgets_and_attributes.dart';
import 'package:FurEverHome/utils/app_colors.dart';
import 'package:FurEverHome/widgets/pet_view_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final FurEverHomeCubit _furEverHomeCubit;
  late final ScrollController _scrollController;
  late final FocusNode _focusNode;
  late final TextEditingController _searchTextController;

  @override
  void initState() {
    _furEverHomeCubit = context.read<FurEverHomeCubit>();
    _scrollController = ScrollController();
    _furEverHomeCubit.fetchData();
    _focusNode = FocusNode();
    _searchTextController = TextEditingController();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            sizedBoxH10,
            _searchWidget(),
            Expanded(
              child: NotificationListener(
                onNotification: (notification) {
                  if (_scrollController.hasClients) {
                    if (_scrollController.offset ==
                            _scrollController.position.maxScrollExtent &&
                        _furEverHomeCubit.petForAdoptionList.length > 5) {
                      _furEverHomeCubit.fetchData();
                    }
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: BlocBuilder<FurEverHomeCubit, FurEverHomeState>(
                    builder: (context, state) {
                      if (state is FurEverHomeLoading) {
                        const CupertinoActivityIndicator(
                            radius: 50.0, color: CupertinoColors.activeBlue);
                      }
                      if (_furEverHomeCubit.petForAdoptionList.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.cancel_rounded,
                                color: Colors.red,
                              ),
                              sizedBoxW10,
                              Text(
                                "No Result Found",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_searchTextController.text.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.celebration_rounded,
                                    color: AppColors.buttonColor,
                                  ),
                                  sizedBoxW10,
                                  Text(
                                    "${_furEverHomeCubit.petForAdoptionList.length} Results Found",
                                    style: const TextStyle(
                                      color: AppColors.buttonColor,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                _furEverHomeCubit.petForAdoptionList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PetViewCard(
                                    petForAdoption: _furEverHomeCubit
                                        .petForAdoptionList[index],
                                  ),
                                  sizedBoxH30
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchWidget() {
    return BlocBuilder<FurEverHomeCubit, FurEverHomeState>(
      builder: (context, state) {
        return TextField(
          onChanged: ((value) {
            _furEverHomeCubit.searchResult(value);
          }),
          focusNode: _focusNode,
          controller: _searchTextController,
          cursorColor: Colors.green,
          cursorHeight: 18,
          cursorWidth: 1.5,
          style: TextStyle(fontSize: 18, color: Colors.blue[800]),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              fillColor: Colors.white,
              filled: true,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: Colors.green),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: Colors.orange),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: Colors.blue[300]!),
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    width: 1,
                  )),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.red)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.red)),
              hintText: "Search",
              hintStyle: TextStyle(fontSize: 18, color: Colors.blue[600]),
              errorMaxLines: 1,
              errorStyle: const TextStyle(
                height: 0.001,
                color: Colors.transparent,
                fontSize: 0,
              ),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchTextController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchTextController.clear();
                        _furEverHomeCubit.endIndex = 0;
                        _furEverHomeCubit.fetchData();
                      },
                      icon: const Icon(Icons.delete_outline_rounded))
                  : null),
        );
      },
    );
  }
}
