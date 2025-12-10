part of 'image_pick_bloc.dart';

@immutable
sealed class ImagePickState {}

final class ImagePickInitial extends ImagePickState {}

class ImagePickLoaded extends ImagePickState {
  final XFile image;
  ImagePickLoaded({required this.image});
}

class ImagePickError extends ImagePickState {
  final String message;
  ImagePickError({required this.message});
}
