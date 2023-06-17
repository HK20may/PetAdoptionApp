part of 'fur_ever_home_cubit.dart';

abstract class FurEverHomeState extends Equatable {
  const FurEverHomeState();

  @override
  List<Object> get props => [];
}

class FurEverHomeInitial extends FurEverHomeState {}

class FurEverHomeLoading extends FurEverHomeState {}

class FurEverHomeData extends FurEverHomeState {
  final List<Pet> petForAdoption;

  const FurEverHomeData({required this.petForAdoption});

  @override
  List<Object> get props => [petForAdoption];
}
