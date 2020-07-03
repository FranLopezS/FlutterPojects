// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:latlong/latlong.dart';

ScanModel welcomeFromJson(String str) => ScanModel.fromJson(json.decode(str));

String welcomeToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
    int id;
    String tipo;
    String valor;

    ScanModel({
        this.id,
        this.tipo,
        this.valor,
    }){
      if(this.valor.contains('http')) {
        this.tipo = 'http';
      } else {
        this.tipo = 'geo';
      }
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id    : json["id"],
        tipo  : json["tipo"],
        valor : json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id"    : id,
        "tipo"  : tipo,
        "valor" : valor,
    };

    getLatLng() {
      final lalo = valor.substring(4).split(',');
      final lat = double.parse(lalo[0]);
      final lng = double.parse(lalo[1]);

      return LatLng(lat, lng);
    }
}
