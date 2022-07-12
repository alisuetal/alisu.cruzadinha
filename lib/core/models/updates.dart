class Update {
  final String version;
  final String description;

  const Update({
    required this.version,
    required this.description,
  });
}

List<Update> updates = [
  const Update(
    version: "2.0.0",
    description:
        "A versão 2.0.0 do Cruzadinha chegou!\n\nEscolha entre diferentes modos de jogo, resolva palavras maiores e compartilhe seu resultado!",
  )
];
