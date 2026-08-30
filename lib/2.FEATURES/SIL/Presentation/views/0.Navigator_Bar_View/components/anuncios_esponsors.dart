class AnunciosEsponsors {
  final String nombre;
  final String imagenUrl;
  final String description;
  final String numero;
  final String direccion;

  AnunciosEsponsors(
      {required this.nombre,
      required this.imagenUrl,
      required this.description,
      required this.numero,
      required this.direccion});
}

List<AnunciosEsponsors> anunciosEsponsors = [
  AnunciosEsponsors(
    nombre: "A TODA LEÑA",
    imagenUrl:
        "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/Anuncios%20Locales%2FA%20TODA%20LE%C3%91A.png?alt=media&token=49c86bc5-f991-4354-a830-c65b6197a2e9",
    description: "Pollos a la brasa y parrilladas en San Ignacio",
    numero: "+51 912366072",
    direccion: "Jr. Huáscar N°245 - San Ignacio",
  ),
  AnunciosEsponsors(
    nombre: "SINAI",
    imagenUrl:
        "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/Anuncios%20Locales%2FSINAI.png?alt=media&token=1980c622-200d-4dab-acb6-6cfaa04e435e",
    description: "Consultas medicas, análisis clínicos y medicamentos en San Ignacio",
    numero: "+51 919014091",
    direccion: "Jr. Provenir N°340 - San Ignacio",
  ),
  AnunciosEsponsors(
    nombre: "Roy & Asociados",
    imagenUrl:
        "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/Anuncios%20Locales%2FROY%20CUEVA%20%26%20ASOCIADOS.png?alt=media&token=cea3bfae-4d38-4027-967a-a28a63e444e7",
    description: "Abogado litigante en temas penales en San Ignacio",
    numero: "+51 929306852",
    direccion: "Calle Los Pinos N°265 - San Ignacio",
  ),
  AnunciosEsponsors(
    nombre: "POLLERIA MI GABRIEL",
    imagenUrl:
        "https://firebasestorage.googleapis.com/v0/b/turismo-san-ignacio-3a655.appspot.com/o/Anuncios%20Locales%2FMI%20GABRIEL.png?alt=media&token=a46005e3-fd0e-4cc6-804c-325657dd18b1",
    description: "Pollos a la brasa y menus en San Ignacio",
    numero: "+51 943037645",
    direccion: "Av. San Ignacio N°321 - San Ignacio",
  ),
];
