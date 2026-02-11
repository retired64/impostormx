import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import '../config/theme.dart';
// Asegúrate de que este archivo exista en la ruta correcta:
import '../utils/sound_manager.dart';

class BouncyButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final IconData? icon;
  const BouncyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.accent,
    this.icon,
  });
  @override
  State<BouncyButton> createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.95).animate(_ctrl);
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;
    return GestureDetector(
      onTapDown: (_) => !isDisabled ? _ctrl.forward() : null,
      onTapUp: (_) {
        if (!isDisabled) {
          _ctrl.reverse();
          // 1. VIBRACIÓN
          Vibration.vibrate(duration: 15);
          // 2. SONIDO (Aquí conectamos tu click.mp3)
          SoundManager.playClick();
          // 3. ACCIÓN
          widget.onPressed?.call();
        }
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: isDisabled ? Colors.white10 : widget.color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isDisabled
                ? []
                : [
                    BoxShadow(
                      color: widget.color.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: Colors.black87),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text.toUpperCase(),
                style: TextStyle(
                  // CAMBIO DE FUENTE: Usamos tu Bungee local
                  fontFamily: 'Bungee',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDisabled ? Colors.white38 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MinimalInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final TextInputType keyboard;
  final Function(String)? onChanged;
  final int? maxLength;
  const MinimalInput({
    super.key,
    required this.controller,
    required this.hint,
    this.isPassword = false,
    this.keyboard = TextInputType.text,
    this.onChanged,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboard,
        onChanged: onChanged,
        // CAMBIO DE FUENTE: Usamos YoungSerif para el texto que escribe el usuario
        style: const TextStyle(
          fontFamily: 'YoungSerif',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white24,
            fontFamily: 'YoungSerif',
          ),
          border: InputBorder.none,
          counterText: "",
        ),
        maxLength: maxLength ?? (isPassword ? 4 : 20),
      ),
    );
  }
}
