import 'dart:io';
import 'package:flutter/material.dart';

class ImagenProducto extends StatelessWidget {
  final String? url;

  const ImagenProducto({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 36, right: 84, top: 595),
      child: Container(
          width: double.infinity,
          height: 50,
          child: ClipRRect(
            child: getImage(url),
          ),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              //borderRadius: BorderRadius.circular(20),
          )),
    );
  }
  Widget getImage(String? imagen){
    String resp;
    if(imagen == null){
      resp= '/Adjunta/Archivo.pdf';
      
    } else if (imagen.startsWith('http')) {
     resp = "Enviado";
    }else{
      resp = imagen;
    }
    return Column(
      children: [
        Text(
          resp,
          style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.w300,
            fontSize: 16,
            height: 2,
          ),
          textAlign: TextAlign.center,

        ),
      ],
    );
  }
}
