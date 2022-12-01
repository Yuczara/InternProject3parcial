import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:productos_app/models/productLine.dart';


class ProductLineService extends ChangeNotifier {
  final String _baseUrl = 'huaweiintership-default-rtdb.firebaseio.com';

  final List<ProductLine> productLines = [];

  bool isLoading = true;
  bool isSaving = false;

  ProductLine? productLineSeleccionado;
  File? pictureFile;

  //constructor
  ProductLineService() {
    this.obtenerProductLines();
  }

  //método que obtiene los productLines de la BD
  Future obtenerProductLines() async {
    bool isLoading = true;
    notifyListeners();
    
    final url = Uri.https(_baseUrl, 'productLines.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productLinesMAp = json.decode(resp.body);

     print(productLinesMAp);

    //Recorremos el mapa y extraemos cada productLine y agregarlo a la lista
    productLinesMAp.forEach((key, value) {
      final productLineTemp = ProductLine.fromMap(value);
      productLineTemp.id = key;
      this.productLines.add(productLineTemp);
    });

    this.isLoading = false;
    notifyListeners();

    // print(this.productLines[0].nombre);

    return this.productLines;
  }

  //metodo para actualizar un productLine en la BD
  Future<String> updateProductLine(ProductLine productLine) async {
    final url = Uri.https(_baseUrl, 'productLines/${productLine.id}.json');
    final resp = await http.put(url, body: productLine.toJson());
    final decodeData = resp.body;

    print(decodeData);

    //actualiza el listado de productLines
    final index = this.productLines.indexWhere((element) => element.id == productLine.id);
    this.productLines[index] = productLine;
    return productLine.id!;
  }

  //método para crear o actualizar un productLine
  Future saveOrCreateProductLine(ProductLine productLine) async {
    isSaving = true;
    notifyListeners();

    if (productLine.id == null) {
      //productLine nuevo
      await this.createProductLine(productLine);
    } else {
      //actualizar productLine existente
      await this.updateProductLine(productLine);
    }

    isSaving = false;
    notifyListeners();
  }

  //metodo para crear un productLine nuevo
  Future<String> createProductLine(ProductLine productLine) async{
    final url = Uri.https(_baseUrl,'productLines.json');
    final resp = await http.post(url, body:productLine.toJson());
    final decodeData = json.decode(resp.body);

    productLine.id = decodeData['name'];
    this.productLines.add(productLine);

    //print(decodeData);
    return productLine.id!;
  }

  //Método para actualizar la imagen del productLine
  /*void actualizarImagenProductLine(String path){
    this.productLineSeleccionado!.imagen = path;
    this.pictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }*/

  //mètodo para subir la imagen a cloudinary
  /*Future<String?> uploadImage()async {
    if(this.pictureFile == null) return null;
    this.isSaving = true;
    notifyListeners();
    final url = 
      Uri.parse("https://api.cloudinary.com/v1_1/ddzuvegby/image/upload?upload_preset=l7ng5v15");

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('field', pictureFile!.path);

    final StreamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(StreamResponse);

    //print(resp);
    //verificamos estatus de la respuesta
    if(resp.statusCode != 200 && resp.statusCode !=201){
      print('Error en la petición');
      print(resp.body);
      return null;
    }

    this.pictureFile = null;
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }*/
}
