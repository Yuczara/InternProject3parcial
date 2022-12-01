import 'package:flutter/material.dart';
import 'package:productos_app/models/producto.dart';

class ProductoFormProvider extends ChangeNotifier{

  GlobalKey<FormState> FormKey = 
    new GlobalKey<FormState>();

  Producto producto;

ProductoFormProvider(this.producto);

bool isValidForm(){
  print(producto.nombre);
  print(producto.telefono);
  //print(producto.disponible);
  print(producto.correo);
  return FormKey.currentState?.validate()?? false;
}

updateDisponible(bool value){
  print(value);
  ///this.producto.disponible = value;
  notifyListeners();
}

}