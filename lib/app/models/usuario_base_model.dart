abstract class UsuarioBase {
  int? get id;
  String get nomeRazao;
  String get email;
  String get password;
  String get cpfCnpj;

  Map<String, dynamic> toMap();

  factory UsuarioBase.fromMap(Map<String, dynamic> map) {
    return UsuarioBase.fromMap(map);
  }
}
