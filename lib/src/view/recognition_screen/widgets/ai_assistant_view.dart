import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/ai_assistant_cubit/ai_assistant_cubit.dart';

class AIAssistantView extends StatelessWidget {
  const AIAssistantView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AIAssistantCubit(),
      child: const _AIAssistantViewBody(),
    );
  }
}

class _AIAssistantViewBody extends StatefulWidget {
  const _AIAssistantViewBody();

  @override
  State<_AIAssistantViewBody> createState() => _AIAssistantViewBodyState();
}

class _AIAssistantViewBodyState extends State<_AIAssistantViewBody>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      context.read<AIAssistantCubit>().updateParticles();
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          context.read<AIAssistantCubit>().initParticles(
            Size(constraints.maxWidth, constraints.maxHeight),
          );

          return BlocBuilder<AIAssistantCubit, AIAssistantState>(
            builder: (context, state) {
              return CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: MeshNetworkPainter(state.particles),
              );
            },
          );
        },
      ),
    );
  }
}

class MeshNetworkPainter extends CustomPainter {
  final List<Particle> particles;

  MeshNetworkPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = AppPalette.blue.withValues(alpha: .9)
      ..strokeWidth = 1.0;

    final paintDot = Paint()
      ..color = AppPalette.blue.withValues(alpha: 0.3)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        double dist = (particles[i].position - particles[j].position).distance;
        if (dist < 100) {
          paintLine.color = AppPalette.blue.withValues(
            alpha: 1.0 - (dist / 100),
          );
          canvas.drawLine(
            particles[i].position,
            particles[j].position,
            paintLine,
          );
        }
      }
    }

    for (var particle in particles) {
      canvas.drawCircle(particle.position, 3.0, paintDot);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
