// To parse this JSON data, do
//
//     final producto = productoFromMap(jsonString);

import 'dart:convert';

class ProductLine {
    ProductLine({
       required this.icon,
       required this.nombre,
       required this.subtitulo,
       required this.informacion,
       this.subtitulo2,
       this.informacion2,
       this.subtitulo3,
       this.informacion3,
       this.id,
    });

    String icon;
    String nombre;
    String subtitulo;
    String informacion;
    String? subtitulo2;
    String? informacion2;
    String? subtitulo3;
    String? informacion3;
    String? id;

    factory ProductLine.fromJson(String str) => ProductLine.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductLine.fromMap(Map<String, dynamic> json) => ProductLine(
        icon: json["icon"],
        nombre: json["nombre"],
        subtitulo: json["subtitulo"],
        informacion: json["informacion"],
        subtitulo2: json["subtitulo2"],
        informacion2: json["informacion2"],
        subtitulo3: json["subtitulo3"],
        informacion3: json["informacion3"],
    );

    Map<String, dynamic> toMap() => {
        "icon": icon,
        "nombre": nombre,
        "subtitulo": subtitulo,
        "informacion": informacion,
        "subtitulo2": subtitulo2,
        "informacion2": informacion,
        "subtitulo3": subtitulo,
        "informacion3": informacion

    };

    ProductLine copy() => ProductLine(
      icon: this.icon,
      nombre: this.nombre,
      subtitulo: this.subtitulo,
      informacion: this.informacion,
      subtitulo2: this.subtitulo2,
      informacion2: this.informacion2,
      subtitulo3: this.subtitulo3,
      informacion3: this.informacion3,
      id: this.id
    );
}
