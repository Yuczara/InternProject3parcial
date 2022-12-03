import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:productos_app/models/producto.dart';

class CandidatoCard extends StatelessWidget {
  final Producto producto;

  const CandidatoCard({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: DataTable(
          columns: [
            DataColumn(label: Text("")),
            DataColumn(label: Text("")),
            //DataColumn(label: Text(producto.cv.toString())),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text('Nombre:${producto.nombre}\n Correo: ${producto.correo}\n Telefono:${producto.telefono}\n'),),
                DataCell(TextButton(onPressed:(){ launch(producto.cv.toString());}, child: Text("CV"))),
              ]
            )
          ],
        ),    
      ),
    );
    /*return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        //color:Colors.red
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 7),
                blurRadius: 10,
              )
            ]),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
           // _BackgroundImage(producto.imagen),
            _DetallesProducto(
              nombre: producto.nombre,

              id: producto.id!,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _Precio(telefono: producto.telefono),
            ),
          ],
        ),
      ),
    );*/
  }
}

class _BackgroundImage extends StatelessWidget {
  final String? url;
  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null
            ? Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover)
            : FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

class _DetallesProducto extends StatelessWidget {
  final String nombre;
  final String id;

  const _DetallesProducto({super.key, required this.nombre, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        //color: Colors.indigo,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              id,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              topRight: Radius.circular(20),
            )),
      ),
    );
  }
}

class _Precio extends StatelessWidget {
  final String telefono;
  const _Precio({super.key, required this.telefono});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '\$$telefono',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ));
  }
}

class _NoDisponible extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No Disponible',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
    );
  }
}
