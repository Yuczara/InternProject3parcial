import 'package:flutter/material.dart';
import 'package:productos_app/Pages/loading_page.dart';
import 'package:productos_app/models/producto.dart';
import 'package:productos_app/widgets/candidato_card.dart';
import 'package:productos_app/widgets/producto_card.dart';
import 'package:provider/provider.dart';

import '../services/producto_service.dart';

class DatosPage extends StatelessWidget {
  const DatosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productoService = Provider.of<ProductoService>(context);
    if (productoService.isLoading) return LoadingPage();

    return Scaffold(
      appBar: AppBar(
        title: Text('Candidatos'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Text("Datos de los Candidatos",
            style:TextStyle(
              fontSize: 25,
              height: 3,
              fontWeight: FontWeight.w800,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productoService.productos.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                  onTap: () {},
                  child: CandidatoCard(
                    producto: productoService.productos[index],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
