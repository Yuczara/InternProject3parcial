import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';


class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future uploadFile() async{
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {
      print("completado archivo");
    });

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('url file: $urlDownload');
    return urlDownload;
  }
  
  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles();
    if(result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UploadFile"),
        centerTitle: true,
      ),
      body: Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(pickedFile != null)
            Expanded(
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Text(pickedFile!.name),
                ),
              ),
            ),
          ElevatedButton(
            child: Text("Select File"),
            
            onPressed: selectFile,
          ),
          ElevatedButton(
            child: Text("upload File"),
            onPressed: uploadFile,
          ),
          SizedBox(height: 32),
        ],
       ),
      ),
    );
  }
}
 