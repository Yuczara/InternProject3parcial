/*import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:productos_app/models/candidato.dart';
import 'package:productos_app/providers/candidato_form_provider.dart';
import 'package:productos_app/services/candidato_service.dart';
import 'package:provider/provider.dart';

class CandidatoPage extends StatefulWidget {
  const CandidatoPage({super.key});
  
  @override
  State<CandidatoPage> createState() => _CandidatoPageState();
}

class _CandidatoPageState extends State<CandidatoPage> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
  var result = await FilePicker.platform.pickFiles();
  if (result == null) {
      return;
  }
  setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
  final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('url file: $urlDownload');
 }

  final GlobalKey<FormState> formkey = new GlobalKey();
  Candidato candidato = Candidato(cv: "", nombre: "", telefono: "", correo: "");
  
  //File cv;
  //final picker = selectFile();
  //String url;

  @override
  Widget build(BuildContext context) {
     final candidatoForm = Provider.of<CandidatoFormProvider>(context);
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Postulación"),
        backgroundColor: Colors.indigo[900],
        elevation: 0.0,
      ),
     body: SingleChildScrollView(
      child: Container(
        child:Padding(
          padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formkey,
        child: Column(
          children: <Widget>[
           /* Container(
              child: cv == null
             ? Text("selecciona una imagen")
             :  Image.file(
                  cv, 
                  height: 300.0, 
                  width:  600.0,
                  ),
            ),           
          SizedBox(
            height: 15.0,
          ),*/
          TextFormField(
             decoration: InputDecoration(
               labelText: "Nombre",
               labelStyle: TextStyle(
                 color: Colors.teal[800],
                 fontSize: 20.0
               ),
               focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.indigo, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
               ),
               fillColor: Colors.white, filled: true,
             ),
             initialValue: candidato.nombre,
                onChanged: (val) => candidato.nombre = val,
              validator: (val) {
                //return val.isEmpty ? "Completa el campo": null;
              },
          ),
          SizedBox(height: 15.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "telefono",
              labelStyle: TextStyle(
                color: Colors.teal[800],
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.indigo, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              fillColor: Colors.white, filled: true,
            ),
            onChanged: (value) => candidato.telefono = value,
            validator: (vauel){
             //return val.isEmpty ? "Completa el campo": null;
            },
          ),SizedBox(height: 15.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "correo",
              labelStyle: TextStyle(
                color: Colors.teal[800],
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.indigo, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              fillColor: Colors.white, filled: true,
            ),
            onChanged: (val) => candidato.correo = val,
            validator: (val){
             //return val.isEmpty ? "Completa el campo": null;
            },
          ),SizedBox(height: 15.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "cv",
              labelStyle: TextStyle(
                color: Colors.teal[800],
              ),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.indigo, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              fillColor: Colors.white, filled: true,
            ),
            onChanged: (val) => candidato.cv = val,
            validator: (val){
             //return val.isEmpty ? "Completa el campo": null;
            },
          ),
           SizedBox(height: 15.0,
          ),
          FloatingActionButton(
            elevation: 10.0,
            child: Text("Guardar"),
           // textColor: Colors.white,
           // color: Colors.indigo[900],
            onPressed:(){
               candidatoService.createCandidato(Form.candidato);
             //uploadStatusImage();
             //insertCandidato();
             //Navigator.pop(context);
            },
          )
          ],
        ),
      ),
     ),
    ),
    ),
    floatingActionButton: FloatingActionButton(
        onPressed: 
        getImage,
        tooltip: "Add image",
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.indigo[900],
        ),
    );
  }




  void insertCandidato() {
    CandidatoService candidatoService = CandidatoService(candidato.toMap());
      candidatoService.addPost();

      */
    // await candidatoService.CreateProducto(productoForm.producto);
   /* final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();*/
      //candidato.date = DateTime.now().millisecondsSinceEpoch;
  //  }
 // }

 /*bool validateAndSave(){
    final FormState form = formkey.currentState;
    if(form.validate()){
      return true;
    } else {
      return false;
    }
  }*/
 
  

 /* void uploadStatusImage() async {
    if(validateAndSave()){
      ///subir la imagen a firebase storage
      final StorageReference postImageRef = 
      FirebaseStorage.instance.ref().child("Post Images");
      var timeKey = DateTime.now();
      final StorageUploadTask uploadTask = 
      postImageRef.child(timeKey.toString()+".jpg").putFile(image);
      var imageUrl = await(await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      print("IMAGE URL: "+ url );
      post.imagen = url;
      PostService postService = PostService(post.toMap());
      postService.addPost();
       // Guardar el post a firebase database: database realtime
    }
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/providers/candidato_form_provider.dart';
import 'package:productos_app/services/candidato_service.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class CandidatoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final candidatoService = Provider.of<CandidatoService>(context);
    //return _CandidatoPageBody(candidatoService: candidatoService);
    return ChangeNotifierProvider(
      create: (_) =>
          CandidatoFormProvider(candidatoService.candidatoSeleccionado!),
      child: _CandidatoPageBody(candidatoService: candidatoService),
    );
  }
}

class _CandidatoPageBody extends StatelessWidget {
  const _CandidatoPageBody({
    Key? key,
    required this.candidatoService,
  }) : super(key: key);

  final CandidatoService candidatoService;

  @override
  Widget build(BuildContext context) {
    final candidatoForm = Provider.of<CandidatoFormProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                 /* ImagenCandidato(
                    url: candidatoService.candidatoSeleccionado!.imagen,
                  ),*/
                  Positioned(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    top: 60,
                    left: 20,
                  ),
              /*    Positioned(
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final picker = new ImagePicker();
                        final PickedFile? pickedFile =
                        await picker.getImage(
                          source: ImageSource.camera,
                          imageQuality: 100
                          );
                          if(pickedFile == null){
                            print('No se seleccionó nada');
                            return;
                          }
                          print('Imagen: ${pickedFile.path}');
                          candidatoService.actualizarImagenCandidato(pickedFile.path);
                      },
                    ),
                    top: 60,
                    right: 20,
                  ),*/
                ],
              ),
              _CandidatoForm(),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
     /* floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: () async {
          if (!candidatoForm.isValidForm()) return;
          final String? imagenUrl = await candidatoService.uploadImage();
          if(imagenUrl!= null){
            candidatoForm.candidato.imagen = imagenUrl;
          }
            await candidatoService.saveOrCreateCandidato(candidatoForm.candidato);
        },
      ),*/
    );
  }
}

class _CandidatoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final candidatoForm = Provider.of<CandidatoFormProvider>(context);
    final candidato = candidatoForm.candidato;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
        ),
        child: Form(
            key: candidatoForm.FormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: candidato.nombre,
                  onChanged: (value) => candidato.nombre = value,
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'El nombre es obligatorio';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Nombre del candidato',
                      labelText: 'Nombre',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.deepPurple,
                      )),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: candidato.correo,
                  onChanged: (value) => candidato.correo = value,
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'El correo es obligatorio';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Correo del candidato',
                      labelText: 'Correo',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.deepPurple,
                      )),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),TextFormField(
                  initialValue: candidato.telefono,
                  onChanged: (value) => candidato.telefono = value,
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'El telefono es obligatorio';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Telefono del candidato',
                      labelText: 'Telefono',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.deepPurple,
                      )),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: candidato.cv,
                  onChanged: (value) => candidato.cv = value,
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'El cv es obligatorio';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'cv del candidato',
                      labelText: 'cv',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.deepPurple,
                      )),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                /*TextFormField(
                  initialValue: '${candidato.precio}',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}')),
                  ],
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      candidato.precio = 0;
                    } else {
                      candidato.precio = double.parse(value);
                    }
                  },
                  decoration: InputDecoration(
                      hintText: '\$99.99',
                      labelText: 'Precio',
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.deepPurple,
                      )),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                SwitchListTile(
                  value: candidato.disponible,
                  title: Text('Disponible'),
                  activeColor: Colors.indigo,
                  onChanged: (value) => candidatoForm.updateDisponible(value),
                ),
                SizedBox(
                  height: 15,
                ),*/
              ],
            )),
      ),
    );
  }
}*/
