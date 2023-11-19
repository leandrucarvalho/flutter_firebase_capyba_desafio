class HomeModel {
  String? nome;
  String? idade;
  String? cidade;

  HomeModel({
    this.nome,
    this.idade,
    this.cidade,
  });

  factory HomeModel.fromFirestore(
    Map<String, dynamic> snapshot,
  ) {
    return HomeModel(
      nome: snapshot['nome'],
      idade: snapshot['idade'],
      cidade: snapshot['cidade'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (nome != null) "nome": nome,
      if (idade != null) "idade": idade,
      if (cidade != null) "cidade": cidade,
    };
  }

  HomeModel copyWith({
    String? nome,
    String? idade,
    String? cidade,
  }) {
    return HomeModel(
      nome: nome ?? this.nome,
      idade: idade ?? this.idade,
      cidade: cidade ?? this.cidade,
    );
  }
}
