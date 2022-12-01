import 'package:flutter/material.dart';
import 'package:productos_app/models/productLine.dart';
class ProductLineFormProvider extends ChangeNotifier{

  GlobalKey<FormState> FormKey = 
    new GlobalKey<FormState>();

  ProductLine productLine;

ProductLineFormProvider(this.productLine);

bool isValidForm(){
  print(productLine.icon);
  print(productLine.nombre);
  print(productLine.subtitulo);
  print(productLine.informacion);
  return FormKey.currentState?.validate()?? false;
}

updateDisponible(bool value){
  print(value);
  //this.productLine.disponible = value;
  notifyListeners();
}

}