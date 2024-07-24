import 'package:flutter/material.dart';

class Spinner<T> extends StatelessWidget {
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String mensaje;

  const Spinner({
    super.key,
    required this.items,
    required this.onChanged,
    required this.mensaje,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      hint: Text(mensaje),
      enableFeedback: true,
      menuMaxHeight: 300,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: mensaje,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(10),
      ),
      items: items.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double ancho;
  final double alto;
  final Color color;

  const AppButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.ancho = 150,
      this.alto = 50,
      this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(ancho, alto),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child:
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 17)),
    );
  }
}

class AppText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;

  const AppText(
      {super.key,
      required this.text,
      this.size = 20,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 3,
        textAlign: TextAlign.justify,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis));
  }
}

class AppFormField extends StatefulWidget {
  final TextEditingController controlador;
  final String etiqueta;
  final tipoTeclado;
  final int maxCaracteres;
  final String? Function(String?)? validator;

  final bool password;

  const AppFormField(
      {super.key,
      required this.controlador,
      required this.etiqueta,
      this.tipoTeclado,
      this.password = false,
      this.maxCaracteres = 50,
      this.validator});

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxCaracteres,
      obscureText: widget.password,
      controller: widget.controlador,
      keyboardType: widget.tipoTeclado,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, introduce un valor';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: widget.etiqueta,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(10),
        counterText: '',
      ),
    );
  }
}

class AppElevatedButton extends StatefulWidget {
  final String texto;
  final Color colorB;
  final Color colorT;
  final VoidCallback onPressed;
  final double ancho;

  const AppElevatedButton(
      {super.key,
      required this.texto,
      required this.colorB,
      required this.onPressed,
      required this.ancho,
      required this.colorT});

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(widget.ancho, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: widget.colorB,
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.texto,
        style: TextStyle(color: widget.colorT, fontSize: 17),
      ),
    );
  }
}
