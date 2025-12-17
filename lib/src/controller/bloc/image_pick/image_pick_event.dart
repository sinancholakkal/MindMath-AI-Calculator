part of 'image_pick_bloc.dart';

@immutable
sealed class ImagePickEvent {}

class ImagePickerEvent extends ImagePickEvent {
  final ImageSource source;

  ImagePickerEvent({required this.source});
}

class ImageAiProcessingEvent extends ImagePickEvent {
  final XFile image;

  ImageAiProcessingEvent({required this.image});
}
