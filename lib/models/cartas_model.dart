
import 'dart:convert';

class CartasMemoramaModel {
  int id;
  String textoCarta;
  int cartaPar;

  CartasMemoramaModel({
    required this.id,
    required this.textoCarta,
    required this.cartaPar,
  });

  factory CartasMemoramaModel.fromRawJson(String str) => CartasMemoramaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartasMemoramaModel.fromJson(Map<String, dynamic> json) => CartasMemoramaModel(
    id: json["id"],
    textoCarta: json["texto_carta"],
    cartaPar: json["carta_par"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "texto_carta": textoCarta,
    "carta_par": cartaPar,
  };
}
