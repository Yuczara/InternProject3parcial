// To parse this JSON data, do
//
//     final producto = productoFromMap(jsonString);

import 'dart:convert';

class Producto {
    Producto({
       //required this.disponible,
       this.cv,
       required this.telefono,
       required this.nombre,
       required this.correo,
       this.id,
    });

    //bool disponible;
    String nombre;
    String? cv;
    String telefono;
    String correo;
    String? id;

    factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        //disponible: json["disponible"],
        cv: json["cv"],
        nombre: json["nombre"],
        correo: json["correo"],
        telefono: json["telefono"],
        
    );

    Map<String, dynamic> toMap() => {
       // "disponible": disponible,
        "cv": cv,
        "telefono": telefono,
        "nombre": nombre,
        "correo":correo,
    };

    Producto copy() => Producto(
     // disponible: this.disponible,
      nombre: this.nombre,
      cv: this.cv,
      correo: this.correo,
      telefono: this.telefono,
      id: this.id
    );
}
