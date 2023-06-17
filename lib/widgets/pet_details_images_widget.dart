import 'dart:ui';

import 'package:FurEverHome/models/pet.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PetDetailsImageWidget extends StatefulWidget {
  final Pet petForAdoption;
  const PetDetailsImageWidget({super.key, required this.petForAdoption});

  @override
  State<PetDetailsImageWidget> createState() => _PetDetailsImageWidgetState();
}

class _PetDetailsImageWidgetState extends State<PetDetailsImageWidget> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      itemCount: widget.petForAdoption.images.length,
      itemBuilder: (context, index) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            ClipRRect(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.petForAdoption.images[index]),
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ExtendedImage.network(
                widget.petForAdoption.images[index],
                printError: false,
                loadStateChanged: (ExtendedImageState state) {
                  if (state.extendedImageLoadState == LoadState.completed) {
                    return state.completedWidget;
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(12),
                      child: CupertinoActivityIndicator(
                          radius: 30.0, color: CupertinoColors.activeBlue),
                    );
                  }
                },
              ),
            ),
            if (widget.petForAdoption.images.length > 1) ...[
              if (index != 0)
                Positioned(
                    left: 13,
                    top: MediaQuery.of(context).size.height * 0.4 / 2 - 10,
                    child: GestureDetector(
                      onTap: () {
                        if (_pageController.hasClients) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade400),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                    )),
              if (index != widget.petForAdoption.images.length - 1)
                Positioned(
                  right: 13,
                  top: MediaQuery.of(context).size.height * 0.4 / 2 - 10,
                  child: GestureDetector(
                    onTap: () {
                      if (_pageController.hasClients) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue.shade400),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.36,
                left: MediaQuery.of(context).size.width / 2 - 20,
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: widget.petForAdoption.images.isEmpty
                      ? 1
                      : widget.petForAdoption.images.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 6,
                    dotHeight: 6,
                    dotColor: Colors.blue.shade500,
                    activeDotColor: Colors.blue.shade900,
                    spacing: 4,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
