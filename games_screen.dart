// Flame game loop, race simulation, track drawing, and arcade vehicle physics.
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'utils/save_data.dart';

class FlameGame {
  Size size = Size.zero;

  Color backgroundColor() => Colors.black;

  void update(double dt) {}

  void render(Canvas canvas) {}
}

class RaceResult {
  const RaceResult({
    required this.position,
    required this.elapsed,
    required this.bestLap,
    required this.coins,
  });

  final int position;
  final double elapsed;
  final double bestLap;
  final int coins;
}

class RacingGame extends FlameGame {
  RacingGame({
    required this.difficulty,
    required this.vehicleId,
    required this.onFinished,
  });

  final String difficulty;
  final String vehicleId;
  final ValueChanged<RaceResult> onFinished;

  bool leftPressed = false;
  bool rightPressed = false;
  bool accelerating = false;
  bool braking = false;
  bool nitroPressed = false;
  double tiltSteering = 0;

  static const int totalLaps = 3;
  static const int opponentCount = 5;
  static const double _lapLength = math.pi * 2;
  final List<double> _opponents = [0.3, 0.8, 1.4, 2.0, 2.6];
  final List<double> _opponentSpeeds = [0.72, 0.80, 0.75, 0.86, 0.77];
  final math.Random _random = math.Random(8);

  double _progress = 0;
  double _speed = 0;
  double _lane = 0;
  double _nitro = 1;
  double _elapsed = 0;
  double _lapElapsed = 0;
  double _bestLap = 0;
  double _countdown = 3.0;
  double _shake = 0;
  double _coins = 0;
  double _obstacleCooldown = 0;
  bool _finished = false;
  int _lastLap = 0;
  double _coinCooldown = 0;

  int get lap => math.min(totalLaps, (_progress / _lapLength).floor() + 1);
  int get position {
    final ahead = _opponents.where((value) => value > _progress).length;
    return ahead + 1;
  }

  double get speed => _speed;
  double get nitro => _nitro;
  double get elapsed => _elapsed;
  double get bestLap => _bestLap;
  int get coinsCollected => _coins.floor();
  bool get raceStarted => _countdown <= 0;

  double get _difficultySpeed => switch (difficulty) {
    'Easy' => 0.70,
    'Hard' => 0.96,
    _ => 0.82,
  };

  double get _carSpeed => switch (vehicleId) {
    'orange' => 1.08,
    'green' => 0.97,
    'gold' => 1.0,
    _ => 1.0,
  };

  double get _nitroMultiplier => vehicleId == 'gold' ? 1.42 : 1.10;

  @override
  Color backgroundColor() => const Color(0xFF087EAA);

  @override
  void update(double dt) {
    super.update(dt);
    if (_finished) return;
    final step = dt.clamp(0, 0.05).toDouble();
    if (_countdown > 0) {
      _countdown -= step;
      return;
    }

    _elapsed += step;
    _lapElapsed += step;
    _obstacleCooldown = math.max(0, _obstacleCooldown - step);
    _coinCooldown = math.max(0, _coinCooldown - step);
    final handling = vehicleId == 'green' ? 1.35 : 1.0;
    if (leftPressed) _lane -= step * handling * 0.86;
    if (rightPressed) _lane += step * handling * 0.86;
    if (tiltSteering.abs() > 2.2) {
      _lane += tiltSteering.clamp(-9, 9) / 9 * step * handling * 0.65;
    }
    _lane *= math.pow(0.985, step * 60).toDouble();
    _lane = _lane.clamp(-1, 1).toDouble();

    final acceleration = accelerating ? 0.58 : -0.17;
    final brakeForce = braking ? 0.95 : 0.0;
    final usingNitro = nitroPressed && _nitro > 0;
    if (usingNitro) {
      _nitro = math.max(0, _nitro - step * 0.32).toDouble();
    } else {
      _nitro = math.min(1, _nitro + step * 0.12).toDouble();
    }
    _speed = (_speed + (acceleration - brakeForce) * step)
        .clamp(0, 1)
        .toDouble();
    final speedFactor = (0.25 + _speed * 0.75) * _carSpeed;
    final previous = _progress;
    _progress +=
        step *
        (usingNitro ? _nitroMultiplier : 0.72) *
        speedFactor *
        (0.72 + _difficultySpeed * 0.28);
    for (var i = 0; i < _opponents.length; i++) {
      _opponents[i] += step * _opponentSpeeds[i] * _difficultySpeed;
    }

    final currentLap = (_progress / _lapLength).floor();
    if (currentLap > _lastLap) {
      _lastLap = currentLap;
      if (_lapElapsed > 0) {
        _bestLap = _bestLap == 0
            ? _lapElapsed
            : math.min(_bestLap, _lapElapsed);
      }
      _lapElapsed = 0;
    }
    if ((previous / _lapLength).floor() != currentLap) _lastLap = currentLap;

    final normalized = _progress % _lapLength;
    if (_obstacleCooldown == 0 &&
        ((normalized - 2.05).abs() < 0.025 ||
            (normalized - 4.65).abs() < 0.025) &&
        _lane.abs() < 0.62) {
      _speed *= 0.55;
      _shake = 0.25;
      _obstacleCooldown = 1.2;
    }
    if ((normalized - 1.10).abs() < 0.025 ||
        (normalized - 3.45).abs() < 0.025) {
      _speed = math.min(1, _speed + step * 1.5).toDouble();
    }
    if (_coinCooldown == 0 &&
        ((normalized - 0.60).abs() < 0.025 ||
            (normalized - 3.00).abs() < 0.025) &&
        _lane.abs() < 0.55) {
      _coins++;
      _coinCooldown = 0.8;
    }
    _shake = math.max(0, _shake - step).toDouble();

    if (_progress >= totalLaps * _lapLength) _completeRace();
  }

  Future<void> _completeRace() async {
    if (_finished) return;
    _finished = true;
    final rank = position;
    final earned =
        10 +
        (rank == 1
            ? 30
            : rank == 2
            ? 18
            : 8) +
        _coins.floor();
    await SaveData.addCoins(earned);
    await SaveData.saveRace(
      score: (10000 / _elapsed).round(),
      bestLapTime: _bestLap,
    );
    onFinished(
      RaceResult(
        position: rank,
        elapsed: _elapsed,
        bestLap: _bestLap,
        coins: earned,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final width = size.x;
    final height = size.y;
    if (width <= 0 || height <= 0) return;
    canvas.save();
    final scale = math.min(width / 900, height / 560);
    canvas.translate((width - 900 * scale) / 2, (height - 560 * scale) / 2);
    canvas.scale(scale);
    if (_shake > 0) {
      canvas.translate(
        (_random.nextDouble() - .5) * 14 * _shake,
        (_random.nextDouble() - .5) * 14 * _shake,
      );
    }
    _drawTrack(canvas);
    _drawPickups(canvas);
    for (var i = 0; i < _opponents.length; i++) {
      _drawCar(canvas, _opponents[i], _laneFor(i), _opponentColor(i), false);
    }
    _drawCar(canvas, _progress, _lane, _playerColor, true);
    if (_countdown > 0) _drawCountdown(canvas);
    canvas.restore();
  }

  Color get _playerColor => switch (vehicleId) {
    'orange' => const Color(0xFFFF8B35),
    'green' => const Color(0xFF56C596),
    'gold' => const Color(0xFFFFC857),
    _ => const Color(0xFF13C5E5),
  };

  Color _opponentColor(int index) => const [
    Color(0xFFFF8B35),
    Color(0xFFE84A5F),
    Color(0xFFFFC857),
    Color(0xFF56C596),
    Color(0xFFB084F5),
  ][index];

  double _laneFor(int index) => math.sin(_opponents[index] * .7 + index) * .48;

  Offset _point(double progress, double lane) {
    final angle = progress % _lapLength - math.pi / 2;
    final rx = 285 + lane * 34;
    final ry = 180 + lane * 27;
    return Offset(450 + math.cos(angle) * rx, 280 + math.sin(angle) * ry);
  }

  void _drawTrack(Canvas canvas) {
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, 900, 560),
      Paint()..color = const Color(0xFF087EAA),
    );
    for (var i = 0; i < 10; i++) {
      canvas.drawCircle(
        Offset((i * 131.0 + 34) % 900, (i * 79.0 + 29) % 560),
        2 + i % 4,
        Paint()..color = Colors.white.withValues(alpha: .13),
      );
    }
    final oval = Rect.fromCenter(
      center: const Offset(450, 280),
      width: 660,
      height: 430,
    );
    canvas.drawOval(oval, Paint()..color = const Color(0xFF25865B));
    canvas.drawOval(
      oval.deflate(64),
      Paint()
        ..color = const Color(0xFF323D4C)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 128,
    );
    canvas.drawOval(
      oval.deflate(64),
      Paint()
        ..color = const Color(0xFFE6E8E8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
    final inner = oval.deflate(128);
    canvas.drawOval(inner, Paint()..color = const Color(0xFF25865B));
    for (var i = 0; i < 18; i++) {
      final a = i * math.pi * 2 / 18;
      final p = Offset(450 + math.cos(a) * 152, 280 + math.sin(a) * 88);
      canvas.drawCircle(p, 2, Paint()..color = Colors.white24);
    }
    for (var i = 0; i < 8; i++) {
      final color = i.isEven ? Colors.white : Colors.black;
      canvas.drawRect(
        Rect.fromLTWH(443 + i * 4.0, 61, 4, 11),
        Paint()..color = color,
      );
    }
    final text = TextPainter(
      text: const TextSpan(
        text: 'SAGAR RIDE',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 4,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    text.paint(canvas, Offset(450 - text.width / 2, 272));
  }

  void _drawPickups(Canvas canvas) {
    for (final progress in [0.60, 3.00]) {
      final p = _point(progress, 0);
      canvas.drawCircle(p, 10, Paint()..color = const Color(0xFFFFC857));
      canvas.drawCircle(
        p,
        6,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
    for (final progress in [1.10, 3.45]) {
      final p = _point(progress, 0);
      canvas.drawCircle(p, 11, Paint()..color = const Color(0xFF3DE0A0));
      canvas.drawCircle(p, 5, Paint()..color = Colors.white);
    }
    for (final progress in [2.05, 4.65]) {
      final p = _point(progress, 0);
      if (progress == 2.05) {
        canvas.drawOval(
          Rect.fromCenter(center: p, width: 25, height: 13),
          Paint()..color = const Color(0xFF131820),
        );
        canvas.drawOval(
          Rect.fromCenter(center: p, width: 15, height: 6),
          Paint()..color = const Color(0xFF343A43),
        );
      } else {
        final cone = Path()
          ..moveTo(p.dx - 8, p.dy + 6)
          ..lineTo(p.dx, p.dy - 9)
          ..lineTo(p.dx + 8, p.dy + 6)
          ..close();
        canvas.drawPath(cone, Paint()..color = const Color(0xFFFF6B2F));
        canvas.drawLine(
          Offset(p.dx - 4, p.dy + 2),
          Offset(p.dx + 4, p.dy + 2),
          Paint()
            ..color = Colors.white
            ..strokeWidth = 2,
        );
      }
    }
  }

  void _drawCar(
    Canvas canvas,
    double progress,
    double lane,
    Color color,
    bool player,
  ) {
    final point = _point(progress, lane);
    final angle = (progress % _lapLength) - math.pi / 2;
    canvas.save();
    canvas.translate(point.dx, point.dy);
    canvas.rotate(angle);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: const Offset(0, 0), width: 27, height: 15),
        const Radius.circular(5),
      ),
      Paint()..color = Colors.black38,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: const Offset(0, 0), width: 24, height: 12),
        const Radius.circular(4),
      ),
      Paint()..color = color,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-3, -4, 8, 8),
        const Radius.circular(2),
      ),
      Paint()..color = const Color(0xFFBCEEFF),
    );
    canvas.drawCircle(
      const Offset(10, -3.5),
      1.6,
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(
      const Offset(10, 3.5),
      1.6,
      Paint()..color = Colors.white,
    );
    if (player && nitroPressed && _nitro > 0) {
      canvas.drawCircle(
        const Offset(-15, 0),
        5,
        Paint()..color = Colors.orange,
      );
    }
    canvas.restore();
  }

  void _drawCountdown(Canvas canvas) {
    final label = _countdown > 0.8 ? _countdown.ceil().toString() : 'GO!';
    final painter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: label == 'GO!' ? const Color(0xFFFFC857) : Colors.white,
          fontSize: 82,
          fontWeight: FontWeight.w900,
          shadows: const [Shadow(color: Colors.black54, blurRadius: 16)],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final scale = 0.9 + 0.1 * math.sin(_countdown * math.pi * 3);
    canvas.save();
    canvas.translate(450, 220);
    canvas.scale(scale);
    painter.paint(canvas, Offset(-painter.width / 2, -painter.height / 2));
    canvas.restore();
  }
}
