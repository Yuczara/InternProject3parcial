import 'package:flutter/material.dart';
import 'package:productos_app/Pages/loading_page.dart';
import 'package:productos_app/models/candidato.dart';
import 'package:productos_app/models/producto.dart';
import 'package:productos_app/services/productLine_service.dart';
import 'package:productos_app/services/producto_service.dart';
import 'package:productos_app/widgets/fondo_huawei.dart';
import 'package:productos_app/widgets/productLine_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productLineService = Provider.of<ProductLineService>(context);
    if (productLineService.isLoading) return LoadingPage();

    return Scaffold(
      //appBar: AppBar(
      //  title: Text('ProductLines'),
      // ),
      body: FondoHuawei(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 210),
            child: Container(
              color: Color.fromARGB(255, 241, 253, 241),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        "Technical Assistance Center",
                        style: TextStyle(
                          color: Color.fromARGB(255, 224, 17, 17),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 2,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        "What you will learn in this course?",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        "Huawei provides six product lines to develop and grow in the one you prefer.",
                        style: TextStyle(
                          color: Colors.black54,
                          //fontWeight: FontWeight.w200,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productLineService.productLines.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                            child: ProductLineCard(
                      productLine: productLineService.productLines[index],
                    )),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(25),
                    color: Colors.red.shade900,
                    elevation: 10,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.fromLTRB(30, 10, 15, 0),
                          title: Text(
                            'Become a part of us!',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 28),
                          ),
                          subtitle: Text(
                            'Apply to the internship program',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                height: 1.5),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () async {
                                final productoService =
                                    Provider.of<ProductoService>(context,
                                        listen: false);
                                productoService.productoSeleccionado =
                                    new Producto(
                                        telefono: '', nombre: '', correo: '');
                                Navigator.pushNamed(context, 'producto');
                              },
                              child: Text(
                                'Apply now',
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade900,
                              ),
                            ),
                            SizedBox(width: 28),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
