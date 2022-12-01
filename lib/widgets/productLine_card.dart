import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:productos_app/models/productLine.dart';

class ProductLineCard extends StatelessWidget {
  final ProductLine productLine;
  const ProductLineCard({Key? key, required this.productLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _DetallesProductLine(
              nombre: productLine.nombre,
              icon: productLine.icon,
              subtitulo: productLine.subtitulo,
              informacion: productLine.informacion,
              id: productLine.id!,

            ),
      ],
    );
  }
}

class _DetallesProductLine extends StatelessWidget {
  final String icon;
  final String nombre;
  final String subtitulo;
  final String informacion;
  final String id;

  const _DetallesProductLine({super.key,required this.icon, required this.nombre,required this.subtitulo, required this.informacion, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6,left: 6, top: 12, bottom: 12),
      child: ExpansionTile(
              leading: CircleAvatar(
                radius: 35,
                child: SvgPicture.network(icon),            
              ), 
              title: Text(
                nombre,
                style: TextStyle(fontSize: 21),
                ),
              children: <Widget>[
                ListTile(                    
                  contentPadding:EdgeInsets.only(left:40, right: 40),               
                  title: Text(
                    subtitulo,
                    style: TextStyle(
                      fontSize: 18,
                      height: 2.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2
                    ),
                    ),
                  subtitle: Text(
                    informacion,
                    style:TextStyle(
                      fontSize: 15,                    
                      fontFamily: 'Roboto',
                      ),
                    textAlign: TextAlign.justify,
                    ),
                ),
              ],
      ),
    );
    
  }
}
