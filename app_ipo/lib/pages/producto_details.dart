import 'package:flutter/material.dart';
import 'package:app_ipo/model/producto_model.dart';
import 'package:app_ipo/model/producto_cantidad_model.dart';
import 'package:app_ipo/model/pedido_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_ipo/data/gestorBBDD.dart';

class ProductDetailsPage extends StatefulWidget {
  //Propiedad inmutable
  final Producto producto;
  Pedido pedidoActual;
  //Usuario usuario;

  ProductDetailsPage({this.producto, this.pedidoActual});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductDetailsState();
  }
}

class _ProductDetailsState extends State<ProductDetailsPage> {
  @override
  bool isFavorito;

  @override
  void initState() {
    super.initState();
    isFavorito = false;
    //isFavorito = user.isFavorito(idProducto);
  }

  Widget _imagenProducto(BuildContext context) {
    return Container(
        //Imagen producto
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    ConectorBBDD.endpointBBDD + widget.producto.imagen),
                fit: BoxFit.fill)));
  }

  Widget _precioProducto(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30),
        child: Text(
          widget.producto.precio.toStringAsFixed(2) + '€',
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  Widget _nombreProducto(BuildContext context) {
    return Text(
      widget.producto.nombre,
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _descripcionProducto(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 50,
            left: MediaQuery.of(context).size.width / 30,
            right: 10),
        child: Text(
          widget.producto.descripcion,
          //textAlign: TextAlign.center,
        ));
  }

  void _toggleFavoriteStatus() {
    if (isFavorito) {
      setState(() {
        isFavorito = false;
        //usuario.eliminarPlatoFavorito()
        Fluttertoast.showToast(msg: "Eliminado de platos favoritos");
      });
    } else {
      setState(() {
        isFavorito = true;
      });
      //usuario.añadirPlatoFavorito()
      Fluttertoast.showToast(msg: "Añadido a platos favoritos");
    }
  }

  Widget _btnAniadirProducto(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          print('Has pulsado añadir al pedido');
          print(widget.pedidoActual.total.toString());
          widget.pedidoActual.insertarProducto(widget.producto);
          print(widget.pedidoActual.total.toString());
        },
        child: Text(
          "Añadir al pedido".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }

  Widget _btnFavorito(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent, // makes highlight invisible to
      onPressed: () {
        _toggleFavoriteStatus();
      },
      icon: new Icon(
        isFavorito ? Icons.favorite : Icons.favorite_border,
        color: Theme.of(context).primaryColor,
        size: 34,
      ),
    );
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Prueba"),
      ),
      body: new Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: new ConstrainedBox(
                constraints: new BoxConstraints(),
                child: Column(
                  children: <Widget>[
                    _imagenProducto(context),
                    _precioProducto(context),
                    _nombreProducto(context),
                    _descripcionProducto(context),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 30,
                  right: MediaQuery.of(context).size.width / 30,
                  bottom: MediaQuery.of(context).size.height / 100,
                ),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  children: <Widget>[
                    _btnAniadirProducto(context),
                    _btnFavorito(context),
                  ],
                )),
          )
        ],
      ),
    );
  }
}