import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {

  final estiloTitulo = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold
  );
  
  final estiloSubtitulo = TextStyle(
    fontSize: 18.0,
    color: Colors.grey
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _crearImagen(),
            _crearTitulo(context),
            _crearAcciones(),
            _crearTexto()
          ],
        ),
      )
    );
  }

  Widget _crearAcciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _crearColumnaIcon(Icons.call, 'CALL'),
        _crearColumnaIcon(Icons.near_me, 'ROUTE'),
        _crearColumnaIcon(Icons.share, 'Share')
      ],
    );
  }

  Widget _crearColumnaIcon(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(height: 5.0,),
        Text(text, style: TextStyle(fontSize: 15.0, color: Colors.blue),)
      ],
    );
  }

  Widget _crearImagen() {
    return Image(
      height: 180.0,
      width: double.infinity,
      fit: BoxFit.cover,
      image: NetworkImage('https://images.pexels.com/photos/132037/pexels-photo-132037.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
    );
  }

  Widget _crearTitulo(BuildContext context) {
    return SafeArea(
    child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 7.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Puerto', style: estiloTitulo),
                  SizedBox(height: 7.0),
                  Text('Un puerto al que va la gente a pasear. Esto son solo diseños, no hay casi funcionalidad. Para ver el sigiente, pulsar el botón inferior.', style: estiloSubtitulo),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'scroll');
                    },
                    child: Text('Ver siguiente diseño')
                    )
                ],
              ),
            ),
            Icon(Icons.star, color: Colors.red, size: 30.0),
            Text('41',style: TextStyle(fontSize: 20.0))
          ],
        ),
      ),
    );
  }

  Widget _crearTexto() {
    return SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt lorem nibh, at feugiat dolor finibus sit amet. Aenean eu nunc quis lectus posuere ultricies vitae rutrum eros. Praesent fringilla, est vel imperdiet luctus, leo felis aliquam augue, sed sollicitudin felis arcu sed mauris. Duis rhoncus ligula ac elit scelerisque, at dictum orci egestas. Aenean vel ligula sed nibh condimentum hendrerit. Mauris id eros enim. Donec quis pellentesque metus. Nunc pretium lacinia elit, non sollicitudin purus. Cras ac ornare nibh. Quisque vitae mauris justo. Integer bibendum feugiat magna. Vivamus ut est sed urna molestie posuere. Maecenas tristique, mi in laoreet sagittis, metus risus elementum risus, vitae pharetra sem purus sed nunc. Sed quis ante vestibulum, mollis dui ac, imperdiet nibh. Donec facilisis lorem risus, sit amet sodales quam ornare sed. Curabitur molestie viverra orci, nec tincidunt velit fringilla non.'+
          'Etiam convallis dictum pharetra. Integer vitae blandit quam. Nullam sodales metus elit, vitae egestas libero sagittis id. Fusce eu erat mattis, posuere justo sed, ornare ipsum. Proin vestibulum, ex non tincidunt porttitor, massa augue ultrices tellus, vitae pharetra augue velit vitae ligula. Sed at nibh ut enim sodales dapibus. Integer eu enim eu massa gravida ornare eget vel metus.',
          
        ),
      ),
    );
  }

}