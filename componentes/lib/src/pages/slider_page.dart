import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  
  double _valorSlider = 100.0;
  bool _bloquearCheck = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Sliders'),
       ),
       body: Container(
         padding: EdgeInsets.only(top: 50.0),
         child: Column(
           children: <Widget>[
             _crearSlider(),
             _crearCheckBox(),
             _crearSwitch(),
             Expanded(child: _crearImagen())
           ],
         ),
       ),
    );
  }

  Widget _crearSlider() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de la imagen',
      //divisions: 20,
      value: _valorSlider,
      min: 10.0,
      max: 400.0,
      onChanged: (_bloquearCheck) ? null : (valor) {
        setState(() {
          _valorSlider = valor;
          print(valor);
        });
      }
    );
  }

  Widget _crearCheckBox() {
    /*return Checkbox(
      value: _bloquearCheck,
      onChanged: (valor) {
        setState(() {
          _bloquearCheck = valor;
        });
      }
    );*/

    return CheckboxListTile(
      title: Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (valor) {
        setState(() {
          _bloquearCheck = valor;
        });
      }
    );
  }

  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (valor) {
        setState(() {
          _bloquearCheck = valor;
        });
      }
    );
  }

  Widget _crearImagen() {
      return Image(
        width: _valorSlider,
        fit: BoxFit.contain,
        image: NetworkImage('https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjI0MX0&w=1000&q=80')
      );
    }

}