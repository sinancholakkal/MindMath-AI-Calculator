import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AIAssistantState {
  final List<Particle> particles;
  AIAssistantState(this.particles);
}

class Particle {
  Offset position;
  Offset velocity;
  final Size size;

  Particle({
    required this.position,
    required this.velocity,
    required this.size,
  });

  void update() {
    position += velocity;
    if (position.dx < 0 || position.dx > size.width) {
      velocity = Offset(-velocity.dx, velocity.dy);
    }
    if (position.dy < 0 || position.dy > size.height) {
      velocity = Offset(velocity.dx, -velocity.dy);
    }
  }
}

class AIAssistantCubit extends Cubit<AIAssistantState> {
  AIAssistantCubit() : super(AIAssistantState([]));

  final Random _random = Random();

  void initParticles(Size size) {
    if (state.particles.isNotEmpty) return;

    final List<Particle> newParticles = [];
    for (int i = 0; i < 30; i++) {
      newParticles.add(
        Particle(
          position: Offset(
            _random.nextDouble() * size.width,
            _random.nextDouble() * size.height,
          ),
          velocity: Offset(
            (_random.nextDouble() - 0.5) * 1.5,
            (_random.nextDouble() - 0.5) * 1.5,
          ),
          size: size,
        ),
      );
    }
    emit(AIAssistantState(newParticles));
  }

  void updateParticles() {
    final particles = state.particles;
    for (var particle in particles) {
      particle.update();
    }
    emit(AIAssistantState(List.from(particles)));
  }
}
