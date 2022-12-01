import 'dart:convert';

class Candidato {
    Candidato({
      this.cv,
       required this.nombre,
       required this.telefono,
       required this.correo,
       required this.disponible,
       this.id,
    });

    String nombre;
    String telefono;
    String correo;
    String? cv;
    String? id;
    bool disponible;

    factory Candidato.fromJson(String str) => Candidato.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Candidato.fromMap(Map<String, dynamic> json) => Candidato(
        nombre: json["nombre"],
        telefono: json["telefono"],
        correo: json["correo"],
        cv: json["cv"],
        disponible: json["disponible"],
        
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "telefono": telefono,
        "correo": correo,
        "cv": cv,
        "disponible": disponible,
    };

    Candidato copy() => Candidato(
      nombre: this.nombre,
      telefono: this.telefono,
      correo: this.correo,
      disponible: this.disponible,
      cv: this.cv,
      id: this.id
    );
}
