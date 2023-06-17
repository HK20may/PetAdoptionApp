import 'package:FurEverHome/models/dummy_data.dart';
import 'package:FurEverHome/models/pet.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fur_ever_home_state.dart';

class FurEverHomeCubit extends Cubit<FurEverHomeState> {
  FurEverHomeCubit() : super(FurEverHomeInitial());

  List<Pet> petForAdoptionList = [];
  List<Pet> petAlreadyAdoptedList = [];
  int endIndex = 0;
  int paginatedItems = 10;

  void fetchData() {
    if (petForAdoptionList.length == pets.length) {
      endIndex = 0;
      return;
    }
    emit(FurEverHomeLoading());
    petForAdoptionList = pets.sublist(0, endIndex + paginatedItems);
    endIndex += paginatedItems;
    emit(FurEverHomeData(petForAdoption: petForAdoptionList));
  }

  void adoptThePet(Pet selectedPet) {
    petAlreadyAdoptedList.add(selectedPet);
    emit(FurEverHomeLoading());
    for (int i = 0; i < petForAdoptionList.length; i++) {
      if (petForAdoptionList[i] == selectedPet) {
        petForAdoptionList[i].adopted = true;
        break;
      }
    }
    emit(FurEverHomeData(petForAdoption: petForAdoptionList));
  }

  void searchResult(String searchedText) {
    petForAdoptionList = pets
        .where((pet) =>
            pet.name.toLowerCase().contains(searchedText.toLowerCase()) ||
            pet.species.toLowerCase().contains(searchedText.toLowerCase()))
        .toList();

    emit(FurEverHomeData(petForAdoption: petForAdoptionList));
  }
}
