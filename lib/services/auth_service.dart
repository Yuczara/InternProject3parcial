import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier{
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebasekey = 'AIzaSyCkha7drYPBvnYRAKqiU4YBtoY-B4ZOPJ8';

  //metodo para crear un usuario
  Future<String?> crearUsuario(String email, String password) async {
    final Map<String,dynamic> authData ={
      'email': email,
      'password':password
    };

    final url = Uri.https(_baseUrl,'/v1/accounts:signUp',{'key': _firebasekey});

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String,dynamic> decodedResp = json.decode(resp.body);
    //print(decodedResp);

    if(decodedResp.containsKey('idToken')){
      return null;
    }else{
      return decodedResp['error']['message'];
    }

  }
  

   //metodo 
  Future<String?> login(String email, String password) async {
    final Map<String,dynamic> authData ={
      'email': email,
      'password':password
    };

    final url = Uri.https(_baseUrl,'/v1/accounts:signInWithPassword',{'key': _firebasekey});

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String,dynamic> decodedResp = json.decode(resp.body);
    //print(decodedResp);

    if(decodedResp.containsKey('idToken')){
      return null;
    }else{
      return decodedResp['error']['message'];
    }

  }
}

  