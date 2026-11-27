// Responsive splash, menus, garage, settings, race HUD, and podium screens.
import 'dart:async';
import 'dart:math' as math;

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../game/racing_game.dart';
import '../utils/save_data.dart';

const _blue = Color(0xFF13C5E5);
const _orange = Color(0xFFFF8B35);
const _gold = Color(0xFFFFC857);

enum _Page { menu, garage, settings, difficulty, race, result }

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..forward();

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1900), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: FadeTransition(
        opacity: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
          child: const SagarLogo(size: 42),
        ),
      ),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _Page page = _Page.menu;
  RaceResult? result;
  String difficulty = 'Medium';

  void _changePage(_Page next) => setState(() => page = next);

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case _Page.garage:
        return GarageScreen(onBack: () => _changePage(_Page.menu));
      case _Page.settings:
        return SettingsScreen(onBack: () => _changePage(_Page.menu));
      case _Page.difficulty:
        return DifficultyScreen(
          onBack: () => _changePage(_Page.menu),
          onSelect: (value) => setState(() {
            difficulty = value;
            page = _Page.race;
          }),
        );
      case _Page.race:
        return RaceScreen(
          difficulty: difficulty,
          vehicleId: SaveData.selectedCar,
          onFinished: (raceResult) => setState(() {
            result = raceResult;
            page = _Page.result;
          }),
          onExit: () => _changePage(_Page.menu),
        );
      case _Page.result:
        return ResultScreen(
          result: result!,
          onRetry: () => _changePage(_Page.difficulty),
          onMenu: () => _changePage(_Page.menu),
        );
      case _Page.menu:
        return _MenuScreen(
          onPlay: () => _changePage(_Page.difficulty),
          onGarage: () => _changePage(_Page.garage),
          onSettings: () => _changePage(_Page.settings),
        );
    }
  }
}

class _MenuScreen extends StatelessWidget {
  const _MenuScreen({
    required this.onPlay,
    required this.onGarage,
    required this.onSettings,
  });

  final VoidCallback onPlay;
  final VoidCallback onGarage;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) => _ScenicPage(
    child: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SagarLogo(size: 38),
            const SizedBox(height: 12),
            Text(
              'COINS  ${SaveData.coins}     BEST  ${_formatTime(SaveData.bestLap)}',
              style: const TextStyle(color: _gold, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 28),
            _ActionButton(
              label: 'PLAY',
              icon: Icons.flag_rounded,
              onPressed: onPlay,
            ),
            _ActionButton(
              label: 'GARAGE',
              icon: Icons.directions_car,
              onPressed: onGarage,
            ),
            _ActionButton(
              label: 'SETTINGS',
              icon: Icons.settings,
              onPressed: onSettings,
            ),
          ],
        ),
      ),
    ),
  );
}

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key, required this.onBack});
  final VoidCallback onBack;

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  static const cars = [
    _CarData('blue', 'Ocean Bolt', Color(0xFF13C5E5), 0, 'BALANCED'),
    _CarData('orange', 'Coral Rush', Color(0xFFFF8B35), 120, 'TOP SPEED'),
    _CarData('green', 'Reef Runner', Color(0xFF56C596), 180, 'HANDLING'),
    _CarData('gold', 'Sun Chaser', Color(0xFFFFC857), 260, 'NITRO'),
  ];

  Future<void> _choose(_CarData car) async {
    if (SaveData.unlockedCars.contains(car.id)) {
      await SaveData.selectCar(car.id);
    } else if (await SaveData.unlockCar(car.id, car.price)) {
      await SaveData.selectCar(car.id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _ScenicPage(
    child: SafeArea(
      child: Column(
        children: [
          _Header(title: 'GARAGE', onBack: widget.onBack),
          Text(
            'COINS  ${SaveData.coins}',
            style: const TextStyle(color: _gold),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth > 650 ? 4 : 2;
                return GridView.builder(
                  padding: const EdgeInsets.all(14),
                  itemCount: cars.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.82,
                  ),
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    final unlocked = SaveData.unlockedCars.contains(car.id);
                    final selected = SaveData.selectedCar == car.id;
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A405A),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected ? _gold : Colors.white12,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_car_filled,
                            size: 52,
                            color: car.color,
                          ),
                          Text(
                            car.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            car.stat,
                            style: const TextStyle(color: _blue, fontSize: 11),
                          ),
                          const SizedBox(height: 8),
                          FilledButton(
                            onPressed: () => _choose(car),
                            child: Text(
                              selected
                                  ? 'SELECTED'
                                  : unlocked
                                  ? 'SELECT'
                                  : '🪙 ${car.price}',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class _CarData {
  const _CarData(this.id, this.name, this.color, this.price, this.stat);
  final String id;
  final String name;
  final Color color;
  final int price;
  final String stat;
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.onBack});
  final VoidCallback onBack;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => _ScenicPage(
    child: SafeArea(
      child: Column(
        children: [
          _Header(title: 'SETTINGS', onBack: widget.onBack),
          ListTile(
            leading: const Icon(Icons.sensors, color: _blue),
            title: const Text('Tilt steering'),
            subtitle: const Text(
              'Tilt your device left or right while racing.',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.touch_app, color: _orange),
            title: const Text('Touch controls'),
            subtitle: const Text(
              'Hold the on-screen buttons to steer and drive.',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.emoji_events, color: _gold),
            title: const Text('Best lap'),
            subtitle: Text(_formatTime(SaveData.bestLap)),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Race in portrait or landscape. Use touch controls or tilt your device to steer.',
            ),
          ),
        ],
      ),
    ),
  );
}

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({
    super.key,
    required this.onBack,
    required this.onSelect,
  });
  final VoidCallback onBack;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) => _ScenicPage(
    child: SafeArea(
      child: Column(
        children: [
          _Header(title: 'CHOOSE DIFFICULTY', onBack: onBack),
          const Spacer(),
          for (final (label, icon) in [
            ('Easy', Icons.sailing),
            ('Medium', Icons.speed),
            ('Hard', Icons.bolt),
          ])
            _ActionButton(
              label: label.toUpperCase(),
              icon: icon,
              onPressed: () => onSelect(label),
            ),
          const Spacer(),
        ],
      ),
    ),
  );
}

class RaceScreen extends StatefulWidget {
  const RaceScreen({
    super.key,
    required this.difficulty,
    required this.vehicleId,
    required this.onFinished,
    required this.onExit,
  });
  final String difficulty;
  final String vehicleId;
  final ValueChanged<RaceResult> onFinished;
  final VoidCallback onExit;

  @override
  State<RaceScreen> createState() => _RaceScreenState();
}

class _RaceScreenState extends State<RaceScreen> {
  late final RacingGame game = RacingGame(
    difficulty: widget.difficulty,
    vehicleId: widget.vehicleId,
    onFinished: (result) =>
        Future<void>.delayed(const Duration(milliseconds: 500), () {
          if (mounted) widget.onFinished(result);
        }),
  );
  Timer? _hudTimer;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    _hudTimer = Timer.periodic(const Duration(milliseconds: 150), (_) {
      if (mounted) setState(() {});
    });
    _accelerometerSubscription = accelerometerEventStream().listen(
      (event) => game.tiltSteering = event.x,
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('Accelerometer unavailable: $error');
      },
    );
  }

  @override
  void dispose() {
    _hudTimer?.cancel();
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxHeight < 450;
          return Stack(
            children: [
              Positioned.fill(child: GameWidget<RacingGame>(game: game)),
              Positioned(
                top: 8,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _HudChip('LAP ${game.lap}/3'),
                    _HudChip(_ordinal(game.position)),
                    _HudChip(_formatTime(game.elapsed)),
                    IconButton(
                      onPressed: widget.onExit,
                      icon: const Icon(Icons.close),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 14,
                bottom: compact ? 12 : 22,
                child: Column(
                  children: [
                    Text(
                      '${(game.speed * 240).round()} KM/H',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        shadows: [Shadow(blurRadius: 5)],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: LinearProgressIndicator(
                        value: game.nitro,
                        color: _blue,
                        backgroundColor: Colors.black54,
                      ),
                    ),
                    const Text('NITRO', style: TextStyle(fontSize: 10)),
                    Text(
                      'BEST ${_formatTime(game.bestLap)}',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 112,
                right: 8,
                bottom: compact ? 8 : 16,
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  fit: BoxFit.scaleDown,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _HoldButton(
                        label: '◀',
                        onChanged: (v) => game.leftPressed = v,
                      ),
                      const SizedBox(width: 6),
                      _HoldButton(
                        label: '▶',
                        onChanged: (v) => game.rightPressed = v,
                      ),
                      const SizedBox(width: 14),
                      _HoldButton(
                        label: 'BRAKE',
                        color: Colors.redAccent,
                        onChanged: (v) => game.braking = v,
                        small: true,
                      ),
                      const SizedBox(width: 6),
                      _HoldButton(
                        label: 'GO',
                        color: _orange,
                        onChanged: (v) => game.accelerating = v,
                        small: true,
                      ),
                      const SizedBox(width: 6),
                      _HoldButton(
                        label: 'N₂O',
                        color: _gold,
                        onChanged: (v) => game.nitroPressed = v,
                        small: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.result,
    required this.onRetry,
    required this.onMenu,
  });
  final RaceResult result;
  final VoidCallback onRetry;
  final VoidCallback onMenu;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _confetti = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat();

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _ScenicPage(
    child: SafeArea(
      child: Stack(
        children: [
          if (widget.result.position == 1)
            Positioned.fill(
              child: CustomPaint(painter: _ConfettiPainter(_confetti)),
            ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.result.position == 1
                        ? 'RACE CHAMPION!'
                        : 'RACE COMPLETE',
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                      color: _gold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _Podium(rank: 2, height: 72),
                      _Podium(rank: 1, height: 100),
                      _Podium(rank: 3, height: 55),
                    ],
                  ),
                  if (widget.result.position == 1) ...[
                    AnimatedBuilder(
                      animation: _confetti,
                      builder: (context, child) => Transform.scale(
                        scale:
                            1 + .08 * math.sin(_confetti.value * math.pi * 2),
                        child: child,
                      ),
                      child: const Icon(
                        Icons.emoji_events,
                        size: 74,
                        color: _gold,
                      ),
                    ),
                    const Text(
                      'Sagar Ride Champion',
                      style: TextStyle(
                        color: _gold,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    '${_ordinal(widget.result.position)}  •  ${_formatTime(widget.result.elapsed)}  •  +${widget.result.coins} coins',
                  ),
                  Text('BEST LAP  ${_formatTime(widget.result.bestLap)}'),
                  const SizedBox(height: 14),
                  _ActionButton(
                    label: 'RETRY',
                    icon: Icons.replay,
                    onPressed: widget.onRetry,
                  ),
                  _ActionButton(
                    label: 'MAIN MENU',
                    icon: Icons.home,
                    onPressed: widget.onMenu,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Podium extends StatelessWidget {
  const _Podium({required this.rank, required this.height});
  final int rank;
  final double height;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        '$rank${rank == 1
            ? 'ST'
            : rank == 2
            ? 'ND'
            : 'RD'}',
        style: const TextStyle(color: _gold, fontWeight: FontWeight.bold),
      ),
      Container(
        width: 70,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: rank == 1 ? _gold : const Color(0xFF1680A0),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
        ),
        child: Text(
          '$rank',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
      ),
    ],
  );
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.animation) : super(repaint: animation);
  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(9);
    for (var i = 0; i < 75; i++) {
      final x = random.nextDouble() * size.width;
      final y =
          (random.nextDouble() * size.height + animation.value * size.height) %
          size.height;
      canvas.drawRect(
        Rect.fromCenter(center: Offset(x, y), width: 5, height: 9),
        Paint()..color = [_gold, _orange, _blue, Colors.white][i % 4],
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => false;
}

class _HoldButton extends StatelessWidget {
  const _HoldButton({
    required this.label,
    required this.onChanged,
    this.color = Colors.white24,
    this.small = false,
  });
  final String label;
  final Color color;
  final bool small;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTapDown: (_) => onChanged(true),
    onTapUp: (_) => onChanged(false),
    onTapCancel: () => onChanged(false),
    child: Container(
      width: small ? 58 : 54,
      height: small ? 52 : 58,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .82),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white38),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
      ),
    ),
  );
}

class _HudChip extends StatelessWidget {
  const _HudChip(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: SizedBox(
      width: 250,
      height: 52,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: label == 'PLAY' ? _orange : const Color(0xFF0B7897),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.onBack});
  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8),
    child: Row(
      children: [
        IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ],
    ),
  );
}

class _ScenicPage extends StatelessWidget {
  const _ScenicPage({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _OceanPainter(),
            child: const SizedBox.expand(),
          ),
        ),
        Positioned.fill(child: child),
      ],
    ),
  );
}

class _OceanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF062B43),
    );
    for (var i = 0; i < 8; i++) {
      final y = size.height * (.22 + i * .12);
      final path = Path()..moveTo(0, y);
      for (var x = 0.0; x <= size.width; x += 24) {
        path.lineTo(x, y + math.sin(x / 55 + i) * 8);
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = const Color(0xFF0A4862).withValues(alpha: .48)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _OceanPainter oldDelegate) => false;
}

class SagarLogo extends StatelessWidget {
  const SagarLogo({super.key, required this.size});
  final double size;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.circle, size: size + 8, color: _orange),
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SAGAR',
            style: TextStyle(
              fontSize: size,
              height: .95,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Container(width: 22, height: 3, color: _orange),
              const SizedBox(width: 6),
              Text(
                'RIDE',
                style: TextStyle(
                  fontSize: size * .72,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                  color: _gold,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

String _ordinal(int value) {
  if (value % 100 >= 11 && value % 100 <= 13) return '${value}TH';
  return '$value${switch (value % 10) {
    1 => 'ST',
    2 => 'ND',
    3 => 'RD',
    _ => 'TH',
  }}';
}

String _formatTime(double seconds) {
  if (seconds <= 0 || !seconds.isFinite) return '--:--';
  final whole = seconds.floor();
  final centiseconds = ((seconds - whole) * 100).floor();
  return '${(whole ~/ 60).toString().padLeft(2, '0')}:${(whole % 60).toString().padLeft(2, '0')}.${centiseconds.toString().padLeft(2, '0')}';
}
