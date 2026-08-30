import 'package:flutter/material.dart' show Colors, MaterialColor;

class AccountItem {
  final String label;
  final String subtitle;
  final String iconPath;
  final int id;

  AccountItem({
    required this.label,
    required this.iconPath,
    required this.subtitle,
    required this.id,
  });
}

final List<MaterialColor> colors = [
  Colors.blue, // Azul
  Colors.red, // Rojo
  Colors.green, // Verde
  Colors.yellow, // Amarillo
  Colors.orange, // Naranja
  Colors.purple, // Morado
  Colors.pink, // Rosa
  Colors.teal, // Verde azulado
  Colors.cyan, // Cian
  Colors.indigo, // Índigo
  Colors.brown, // Marrón
  Colors.grey, // Gris
  Colors.lime, // Lima
  Colors.amber, // Ámbar
  Colors.deepOrange, // Naranja intenso
  Colors.deepPurple, // Morado intenso
  Colors.lightBlue, // Azul claro
  Colors.lightGreen, // Verde claro
  Colors.blueGrey, // Azul grisáceo
  Colors.cyan, // Cian acentuado
];

final List<String> languages = [
  'Español', // Español
  'English', // Inglés
  'Português', // Portugués
  'Français', // Francés
  'Italiano', // Italiano
  'Nederlands', // Neerlandés / Holandés
  '日本語', // Japonés
  'Türkçe', // Turco
  'Polski', // Polaco
  'Svenska', // Sueco
];

List<AccountItem> accountItems = [
  AccountItem(
    id: 1,
    label: "Mis Datos",
    iconPath: "assets/icons/account_icons/details.svg",
    subtitle: "Actualiza tu información personal",
  ),
  AccountItem(
    id: 2,
    label: "Cambiar Idioma",
    iconPath: "assets/icons/account_icons/idioma.svg",
    subtitle: "Selecciona el idioma de la aplicación",
  ),
  AccountItem(
    id: 3,
    label: "Preguntas Frecuentes",
    iconPath: "assets/icons/account_icons/preguntas.svg",
    subtitle: "Respuestas a dudas comunes",
  ),
  AccountItem(
    id: 4,
    label: "Política de Privacidad",
    iconPath: "assets/icons/account_icons/candado.svg",
    subtitle: "Conoce nuestra política de privacidad",
  ),
  AccountItem(
    id: 5,
    label: "Contacto y Referencias",
    iconPath: "assets/icons/account_icons/whatsapp.svg",
    subtitle: "Comunícate con nosotros",
  ),
  AccountItem(
    id: 6,
    label: "Acerca del Fundador",
    iconPath: "assets/icons/account_icons/equipo.svg",
    subtitle: "Conoce la historia detrás de SILFY",
  ),
  AccountItem(
    id: 7,
    label: "Acerca de SILFY",
    iconPath: "assets/icons/account_icons/codigo.svg",
    subtitle: "Información sobre la app",
  ),
  AccountItem(
    id: 8,
    label: "Medidas de Seguridad",
    iconPath: "assets/icons/account_icons/seguridad.svg",
    subtitle: "Viaje seguro con nosotros",
  ),
  AccountItem(
    id: 9,
    label: "Recomendaciones Turísticas",
    iconPath: "assets/icons/account_icons/consejos.svg",
    subtitle: "Consejos útiles para tus viajes",
  ),
  AccountItem(
    id: 10,
    label: "Asociate a CAPTURSI",
    iconPath: "assets/icons/others/turistas.svg",
    subtitle: "Se parte de CAPTURSI",
  ),
  AccountItem(
    id: 11,
    label: "Convenio San Ignacio Emprende y Chardin",
    iconPath: "assets/icons/others/turistas.svg",
    subtitle: "Conoce nuestro convenio",
  ),
  AccountItem(
    id: 12,
    label: "Colabora con el Proyecto",
    iconPath: "assets/icons/account_icons/donacion.svg",
    subtitle: "Apoye esta iniciativa",
  ),
];
