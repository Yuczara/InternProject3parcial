import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:productos_app/models/producto.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductoService extends ChangeNotifier {
  
  final databaseReference = FirebaseDatabase.instance.ref();
  final String _baseUrl = 'huaweiintership-default-rtdb.firebaseio.com';

  final List<Producto> productos = [];

  bool isLoading = true;
  bool isSaving = false;

  Producto? productoSeleccionado;
  File? pictureFile;

  //constructor
  ProductoService() {
    this.obtenerProductos();
  }

  //método que obtiene los productos de la BD
  Future obtenerProductos() async {
    bool isLoading = true;
    notifyListeners();
    
    final url = Uri.https(_baseUrl, 'candidatos.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productosMAp = json.decode(resp.body);

    // print(productosMAp);

    //Recorremos el mapa y extraemos cada producto y agregarlo a la lista
    productosMAp.forEach((key, value) {
      final productoTemp = Producto.fromMap(value);
      productoTemp.id = key;
      this.productos.add(productoTemp);
    });

    this.isLoading = false;
    notifyListeners();

    // print(this.productos[0].nombre);

    return this.productos;
  }

  //metodo para actualizar un producto en la BD
  Future<String> updateProducto(Producto producto) async {
    final url = Uri.https(_baseUrl, 'candidatos/${producto.id}.json');
    final resp = await http.put(url, body: producto.toJson());
    final decodeData = resp.body;

    print(decodeData);

    //actualiza el listado de productos
    final index = this.productos.indexWhere((element) => element.id == producto.id);
    this.productos[index] = producto;
    return producto.id!;
  }

  
  //método para crear o actualizar un producto
  Future saveOrCreateProducto(Producto producto) async {
    isSaving = true;
    notifyListeners();

    if (producto.id == null) {
          await this.createProducto(producto); 
    } else {
      //actualizar producto existente
      await this.updateProducto(producto);
    }

    isSaving = false;
    notifyListeners();
  }


bool productoExistete(){
    return true;
  }

  //metodo para crear un producto nuevo
  Future<String> createProducto(Producto producto) async{
    final url = Uri.https(_baseUrl,'candidatos.json');
    final resp = await http.post(url, body:producto.toJson());
    final decodeData = json.decode(resp.body);

    producto.id = decodeData['name'];
    this.productos.add(producto);

    //print(decodeData);
    return producto.id!;
  }

  //Método para actualizar la imagen del producto
  void actualizarImagenProducto(String path){
    
    this.productoSeleccionado!.cv = path;
    this.pictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
    
  }

  //mètodo para subir la imagen a cloudinary
  Future uploadImage()async {
    if(this.pictureFile == null) return null;
    this.isSaving = true;
    notifyListeners();
  }
}
