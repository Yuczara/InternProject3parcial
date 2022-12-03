import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/providers/producto_form_provider.dart';
import 'package:productos_app/services/producto_service.dart';
import 'package:productos_app/widgets/fondo_huawei.dart';
import 'package:productos_app/widgets/fondo_login.dart';
import 'package:productos_app/widgets/imagen_producto.dart';
import 'package:provider/provider.dart';

class ProductoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productoService = Provider.of<ProductoService>(context);
    //return _ProductoPageBody(productoService: productoService);
    return ChangeNotifierProvider(
      create: (_) =>
          ProductoFormProvider(productoService.productoSeleccionado!),
      child: _ProductoPageBody(productoService: productoService),
    );
  }
}

class _ProductoPageBody extends StatefulWidget {
  const _ProductoPageBody({
    Key? key,
    required this.productoService,
  }) : super(key: key);

  final ProductoService productoService;

  @override
  State<_ProductoPageBody> createState() => _ProductoPageBodyState();
}


class _ProductoPageBodyState extends State<_ProductoPageBody> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  @override
  Widget build(BuildContext context) {
    future:
    Firebase.initializeApp();
    final productoForm = Provider.of<ProductoFormProvider>(context);
    return Scaffold(
      body: FondoLogin(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 190),
                        child: _ProductoForm(),
                      ),
                      ImagenProducto(
                        url: widget.productoService.productoSeleccionado!.cv,
                      ),
                      Positioned(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        top: 10,
                        left: 20,
                      ),
                       Positioned(
                        child: IconButton(
                          icon: Icon(
                            Icons.upload_file_outlined,
                            size: 40,
                            color: Colors.blue.shade900,
                          ),
                          onPressed: () async {
                            //FILE SELECCIONADO
                            final result = await FilePicker.platform.pickFiles();
                            if (result == null) return;

                            setState(() {
                              pickedFile = result.files.first;
                            });

                            if (pickedFile == null) {
                              print('No se seleccionó nada');
                              return;
                            }
                            //print('Imagen: ${pickedFile.path}');
                            print('IMAGEN SELECCIONADA: ${pickedFile!.name}');
                            widget.productoService
                                .actualizarImagenProducto(pickedFile!.name);
                          },
                        ),
                        top: 590,
                        right: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                   MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.deepPurple,
              disabledColor: Colors.grey,
              elevation: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 15,
                ),
                child: Text('Guardar',
                  style:TextStyle(
                    color:Colors.white,
                  ),
                ),
              ),
              onPressed: () async {
          if (!productoForm.isValidForm()) return;
          //SUBIR ARCHIVO

          final path = 'files/${pickedFile!.name}';
          final file = File(pickedFile!.path!);
          final ref = FirebaseStorage.instance.ref().child(path);
          uploadTask = ref.putFile(file);
          final snapshot = await uploadTask!.whenComplete(() {
            print("completado archivo");
          });
          String urlDownload = await snapshot.ref.getDownloadURL();
          print('url file: $urlDownload');

          final String? imagenUrl = await widget.productoService.uploadImage();

          if (urlDownload != null) {
            productoForm.producto.cv = urlDownload;
          }
          await widget.productoService
              .saveOrCreateProducto(productoForm.producto);
          Navigator.of(context).pop();
        },
            )
                ],
              ),
          ),
        ),
      ),
    );
  }
}

class _ProductoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productoForm = Provider.of<ProductoFormProvider>(context);
    final producto = productoForm.producto;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
        ),
        child: Form(
            key: productoForm.FormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                      'Internship Program',
                      style: Theme.of(context).textTheme.headline4),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  initialValue: producto.nombre,
                  onChanged: (value) => producto.nombre = value,
                  validator: (value) {
                    String pattern =
                        r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";
                    RegExp regExp = new RegExp(pattern);
                    return regExp.hasMatch(value ?? '')
                        ? null
                        : 'El nombre no es válido';
                  },
                  decoration: InputDecoration(
                      hintText: 'eg: Juan Perez Lopez',
                      labelText: 'Nombre',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.blue.shade900,
                      )),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue.shade900,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefix: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.blue.shade900,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: producto.correo,
                  onChanged: (value) => producto.correo = value,
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = new RegExp(pattern);
                    return regExp.hasMatch(value ?? '')
                        ? null
                        : 'El correo no es válido';
                  },
                  decoration: InputDecoration(
                      hintText: 'correo.ejemplo@gmail.com',
                      labelText: 'Correo electrónico:',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.blue.shade900,
                      )),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue.shade900,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefix: Icon(
                        Icons.alternate_email_sharp,
                        color: Colors.blue.shade900,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),TextFormField(
                  initialValue: '${producto.telefono}',
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      producto.telefono = "nada";
                    } else {
                      producto.telefono = (value);
                    }
                  },
                  validator: (value) {
                    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = new RegExp(pattern);
                    return regExp.hasMatch(value ?? '')
                        ? null
                        : 'El nombre no es válido';
                  },
                  decoration: InputDecoration(
                    hintText: 'ej 999 999 99 99',
                    labelText: 'telefono',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.blue.shade900,
                    )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue.shade900,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    prefix: Icon(
                      Icons.phone,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: '',
                    labelText: 'Curriculum Vitae',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 56
                ),

              ],
            )),
      ),
    );
  }
}
/*import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/material/text_form_field.dart';
import 'package:productos_app/providers/producto_form_provider.dart';
import 'package:productos_app/services/producto_service.dart';
import 'package:productos_app/widgets/fondo_login.dart';
import 'package:productos_app/widgets/imagen_producto.dart';
import 'package:provider/provider.dart';
import 'package:emailjs/emailjs.dart';
import 'package:http/http.dart' as http;

final nameController = TextEditingController();
final telefonoController = TextEditingController();
final emailController = TextEditingController();

String urlPath = "";
String namevar = "";
String emailvar = "";
String telefonovar = "";
//String messagevar= "";

class ProductoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productoService = Provider.of<ProductoService>(context);
    //return _ProductoPageBody(productoService: productoService);
    return ChangeNotifierProvider(
      create: (_) =>
          ProductoFormProvider(productoService.productoSeleccionado!),
      child: _ProductoPageBody(productoService: productoService),
    );
  }
}

class _ProductoPageBody extends StatefulWidget {
  const _ProductoPageBody({
    Key? key,
    required this.productoService,
  }) : super(key: key);

  final ProductoService productoService;

  @override
  State<_ProductoPageBody> createState() => _ProductoPageBodyState();
}


class _ProductoPageBodyState extends State<_ProductoPageBody> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  @override
  Widget build(BuildContext context) {
    future:
    Firebase.initializeApp();
    final productoForm = Provider.of<ProductoFormProvider>(context);
    return Scaffold(
      body: FondoLogin(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 190),
                        child: _ProductoForm(),
                      ),
                      ImagenProducto(
                        url: widget.productoService.productoSeleccionado!.cv,
                      ),
                      Positioned(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        top: 10,
                        left: 20,
                      ),
                       Positioned(
                        child: IconButton(
                          icon: Icon(
                            Icons.upload_file_outlined,
                            size: 40,
                            color: Colors.blue.shade900,
                          ),
                          onPressed: () async {
                            //FILE SELECCIONADO
                            final result = await FilePicker.platform.pickFiles();
                            if (result == null) return;

                            setState(() {
                              pickedFile = result.files.first;
                            });

                            if (pickedFile == null) {
                              print('No se seleccionó nada');
                              return;
                            }
                            //print('Imagen: ${pickedFile.path}');
                            print('IMAGEN SELECCIONADA: ${pickedFile!.name}');
                            widget.productoService
                                .actualizarImagenProducto(pickedFile!.name);
                          },
                        ),
                        top: 590,
                        right: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                   MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.deepPurple,
              disabledColor: Colors.grey,
              elevation: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 15,
                ),
                child: Text('Guardar',
                  style:TextStyle(
                    color:Colors.white,
                  ),
                ),
              ),
              onPressed: () async {
          if (!productoForm.isValidForm()) return;
          //SUBIR ARCHIVO 

          final path = 'files/${pickedFile!.name}';
          final file = File(pickedFile!.path!);
          final ref = FirebaseStorage.instance.ref().child(path);
          uploadTask = ref.putFile(file);
          final snapshot = await uploadTask!.whenComplete(() {
            //print("completado archivo");
          });
          String urlDownload = await snapshot.ref.getDownloadURL();
          urlPath = urlDownload;
          print('url file: $urlDownload');
          
          final String? imagenUrl = await widget.productoService.uploadImage();

          if (urlDownload != null) {
            productoForm.producto.cv = urlDownload;
          }
          
          await widget.productoService
              .saveOrCreateProducto(productoForm.producto);

          String namevar = nameController.text;
          String emailvar = emailController.text;
          String telefonovar = telefonoController.text;

          sendEmail(name: namevar, email: emailvar, telefono: telefonovar);

          final form = productoForm.FormKey.currentState;

          Navigator.of(context).pop();
          
        },
            )
                ],
              ),
          ),
        ),
      ),
    );
  }
}

Future sendEmail({
  required String name,
  required String email,
  required String telefono,
}) async {
		final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send-form');
		const serviceId = "service_fpw0asd";
		const templateId = "template_idzwizi";
		const userId = "Hs8RrtBuyHiII5Wu7";
		final response = await http.post(url,
		headers: {
      'origin': 'http://localhost',
      'Content-Type': 'application/json'},
			body: json.encode({
			"service_id": serviceId,
			"template_id": templateId,
			"user_id": userId,
			"template_params":{
				"from_user": name,
				"tel_user": telefono,
				"email_user": email,
        "CV": "${urlPath}",			
        },
			})
		);
		return response.statusCode;
	}


class _ProductoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productoForm = Provider.of<ProductoFormProvider>(context);
    final producto = productoForm.producto;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
        ),
        child: Form(
            key: productoForm.FormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                      'Internship Program',
                      style: Theme.of(context).textTheme.headline4),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: nameController,
                  //initialValue: producto.nombre,
                  onChanged: (value) => producto.nombre = value,
                  validator: (value) {
                    String pattern =
                        r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";
                    RegExp regExp = new RegExp(pattern);
                    return regExp.hasMatch(value ?? '')
                        ? null
                        : 'El nombre no es válido';
                  },
                  decoration: InputDecoration(
                      hintText: 'eg: Juan Perez Lopez',
                      labelText: 'Nombre',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.blue.shade900,
                      )),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue.shade900,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefix: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.blue.shade900,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  //initialValue: producto.correo,
                  onChanged: (value) => producto.correo = value,
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = new RegExp(pattern);
                    return regExp.hasMatch(value ?? '')
                        ? null
                        : 'El correo no es válido';
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'correo.ejemplo@gmail.com',
                      labelText: 'Correo electrónico:',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.blue.shade900,
                      )),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue.shade900,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefix: Icon(
                        Icons.alternate_email_sharp,
                        color: Colors.blue.shade900,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),TextFormField(
                  //initialValue: '${producto.telefono}',
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      producto.telefono = "nada";
                    } else {
                      producto.telefono = (value);
                    }
                  },
                  validator: (value) {
                    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = new RegExp(pattern);
                    return regExp.hasMatch(value ?? '')
                        ? null
                        : 'El nombre no es válido';
                  },
                  controller: telefonoController,
                  decoration: InputDecoration(
                    hintText: 'ej 999 999 99 99',
                    labelText: 'telefono',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.blue.shade900,
                    )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue.shade900,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    prefix: Icon(
                      Icons.phone,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: '',
                    labelText: 'Curriculum Vitae',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 56
                ),

              ],
            )),
      ),
    );
  }
}
*/