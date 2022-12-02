import 'package:firebase_database/firebase_database.dart';


class DemoService{
  String nodeName = "candidatos";
 final databaseReference = FirebaseDatabase.instance.ref();
 //final String _baseUrl = 'productosds02sv21ymh-default-rtdb.firebaseio.com';

  Map candidato;

  DemoService(this.candidato);
  
  addCandidato(){
    databaseReference.child(nodeName).push().set(candidato);
  }

  //final String _baseUrl = 'productosds02sv21ymh-default-rtdb.firebaseio.com';
  //final List<Candidato> candidatos= [];

    /*createRecord(Candidato candidato) async {

      databaseReference.child(nodeName).push().set(candidato);
     
      /*CREATE PRODUCTO LIKE
      final url = Uri.https(_baseUrl,'candidatos/${candidato.id}.json');
      final resp = await http.put(url, body: candidato.toJson());
      final decodeData = json.decode(resp.body);
      candidato.id = decodeData['name'];
      this.candidatos.add(candidato);
      return candidato.id!;*/

        /*databaseReference.child("1").set({
          'title': 'Mastering EJB',
          'description': 'Programming Guide for J2EE'
        });
        databaseReference.child("2").set({
          'title': 'Flutter in Action',
          'description': 'Complete Programming Guide to learn Flutter'
        });*/
      }*/

      void updateData(){
        databaseReference.child('1').update({
          'description': 'J2EE complete Reference'
        });
      }
      void deleteData(){
        databaseReference.child('1').remove();
      }
}
/*class PostService{
   final String _baseUrl = 'huaweiintership-default-rtdb.firebaseio.com';
    final List<Post> post= [];
  String nodeName = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map post;

  PostService(this.post);

  addPost(){
//    this is going to give a reference to the posts node
   database.reference().child(nodeName).push().set(post);
  }

  deletePost(){
    database.reference().child('$nodeName/${post['key']}').remove();
  }

  updatePost(){
    database.reference().child('$nodeName/${post['key']}').update(
      {"nombre": post['nombre'], "correo": post['correo'], "telefono":post['telefono'],"cv": post['cv']}
    );
  }
}*/