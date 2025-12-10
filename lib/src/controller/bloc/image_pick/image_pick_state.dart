part of 'image_pick_bloc.dart';

@immutable
sealed class ImagePickState {}

final class ImagePickInitial extends ImagePickState {}

class ImagePickLoaded extends ImagePickState {
  final XFile image;
  final List<num> numbers;
  ImagePickLoaded({required this.image, required this.numbers});
}

class ImagePickError extends ImagePickState {
  final String message;
  ImagePickError({required this.message});
}
