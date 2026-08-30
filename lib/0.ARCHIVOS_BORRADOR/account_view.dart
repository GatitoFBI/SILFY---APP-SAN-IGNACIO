// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../../../../1.CONFIG/Core/constants/app_constants.dart';
// import '../../../../../1.CONFIG/Core/utils/shared/local_storage.dart';
// import '../../bloc/cubit_language/language_cubit.dart';
// import '../../bloc/cubit_recordatorio/recordatorio_cubit.dart';
// import '../../bloc/cubit_theme/theme_cubit.dart';
// import '../../bloc/cubit_username/username_cubit.dart';
// import '../../widgets/app_button.dart';
// import '../../widgets/app_text.dart';
// import '../welcome_view.dart';
// import 'components/account_item.dart';
// import 'components/data_settings_component.dart';
// import 'components/frase_component.dart';
// import 'components/social_item.dart';
// import 'components/views/views.dart';

// class AccountView extends StatelessWidget {
//   const AccountView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const String imagePath = "assets/images/photo.jpg";

//     return Scaffold(
//       extendBody: true,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),

//               //* 📸 Usuario: Foto + Nombre.
//               ListTile(
//                 leading: Container(
//                   width: 64,
//                   height: 64,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: const DecorationImage(
//                       image: AssetImage(imagePath),
//                       // fit: BoxFit.cover,
//                       fit: BoxFit.contain,
//                     ),
//                     color: AppConstants.primaryColor.withOpacity(0.7),
//                   ),
//                 ),
//                 title: AppText(
//                  text: context.watch<UsernameCubit>().state,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 subtitle: const AppText(
//                   text: "Configura tu cuenta",
//                   color: Color(0xff7C7C7C),
//                   fontWeight: FontWeight.normal,
//                   fontSize: 16,
//                 ),
//               ),

//               const Divider(thickness: 1),

//               //* 🌙 Tema Oscuro/Claro.
//               BlocBuilder<ThemeCubit, bool>(
//                 builder: (context, isDarkMode) {
//                   return ListTile(
//                     title: Text(
//                       isDarkMode ? 'Modo Oscuro' : 'Modo Claro',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: isDarkMode ? Colors.white : Colors.black,
//                       ),
//                     ),
//                     leading: Icon(
//                       isDarkMode ? Icons.dark_mode : Icons.light_mode,
//                       color: isDarkMode ? Colors.white : Colors.black,
//                     ),
//                     trailing: Switch(
//                       value: isDarkMode,
//                       onChanged: (value) => context.read<ThemeCubit>().toggleTheme(),
//                     ),
//                   );
//                 },
//               ),

//               const Divider(thickness: 1),

//               //* 🔔 Recordatorio de Notificaciones.
//               BlocBuilder<RecordatorioCubit, bool>(
//                 builder: (context, isRecordatorio) {
//                   return ListTile(
//                     title: const Text(
//                       "Recordatorios",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     leading: SvgPicture.asset(
//                       isRecordatorio
//                           ? 'assets/icons/account_icons/campana_con.svg'
//                           : 'assets/icons/account_icons/campana_sin.svg',
//                       width: 23,
//                       height: 23,
//                       colorFilter: ColorFilter.mode(
//                         context.watch<ThemeCubit>().state ? Colors.white : Colors.black,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                     trailing: Switch(
//                       value: isRecordatorio,
//                       onChanged: (value) => context.read<RecordatorioCubit>().toggleRecordatorio(),
//                     ),
//                   );
//                 },
//               ),

//               const Divider(thickness: 1),

//               //* 📋 Opciones de Cuenta.
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: accountItems.length,
//                 itemBuilder: (context, index) {
//                   final item = accountItems[index];

//                   return Column(
//                     children: [
//                       ListTile(
//                         onTap: () => _getFuction(id: item.id, context: context),
//                         leading: SvgPicture.asset(
//                           item.iconPath,
//                           width: 25,
//                           height: 25,
//                           colorFilter: ColorFilter.mode(
//                             context.watch<ThemeCubit>().state ? Colors.white : Colors.black,
//                             BlendMode.srcIn,
//                           ),
//                         ),
//                         title: Text(
//                           item.label,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         subtitle: Text(
//                           item.label == "Cambiar Idioma"
//                               ? "Lenguaje seleccionado: ${LocalStorage.prefs.getString('language') ?? context.watch<LanguageMethodsCubit>().state.toString()}"
//                               : item.subtitle,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         trailing: const Icon(Icons.arrow_forward_ios),
//                       ),
//                       const Divider(thickness: 1),
//                     ],
//                   );
//                 },
//               ),

//               const SizedBox(height: 10),

//               //* 🚪 Botón de Cerrar Sesión.
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 26.0),
//                 child: AppButton(
//                   widthIcon: 30,
//                   iconColor: Colors.white,
//                   label: "Cerrar sesión",
//                   trailingIconPath: "assets/icons/button_icons/salir.svg",
//                   fontWeight: FontWeight.w600,
//                   padding: const EdgeInsets.symmetric(vertical: 25),
//                   onPressed: () {
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(
//                         builder: (_) => WelcomeView(),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 15),

//               //* 📝 Frase Motivacional.
//               const FraseComponent(
//                 frase:
//                     '"Estamos construyendo la mejor app sobre San Ignacio, combinando innovación, pasión y un equipo que no conoce límites."',
//                 autor: "- Fabricio Ricapa",
//               ),
//               const SizedBox(height: 15),

//               //* 📱 Redes Sociales.
//               siguenosSocialMedia(),
//               const SizedBox(height: 10),

//               //* 🆔 Version de la App y ID.
//               versionAppAndId(),
//               const SizedBox(height: 15),

//               //* 🧠 Mensaje Final Creditos.
//               finalMessage(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _getFuction({
//     required int id,
//     required BuildContext context,
//   }) {
//     switch (id) {
//       case 1:
//         showMyDataDialog(
//           context: context,
//           username: context.read<UsernameCubit>().state.toString(),
//         );
//         break;

//       case 2:
//         showChangedLanguage(
//           context: context,
//           listElements: languages,
//           colors: colors,
//           icon: Icons.language_rounded,
//           type: 'language',
//         );
//         break;

//       case 3:
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return CuestionesFrecuentesView(
//             categoryName: 'Preguntas Frecuentes',
//             categoryDescription: 'Aprende cómo comenzar a usar la aplicación, haz preguntas y deja comentarios.',
//             cuestiones: preguntasFrecuentes,
//           );
//         }));
//         break;

//       case 4:
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return CuestionesFrecuentesView(
//             categoryName: 'Política de Privacidad',
//             categoryDescription: 'Aprende cómo comenzar a usar la aplicación, haz preguntas y deja comentarios.',
//             cuestiones: politicasDePrivacidad,
//           );
//         }));
//         break;

//       case 5:
//         validationMessajeDialog(
//           context: context,
//           title: "¿Quieres contactarte con el desarrollador?",
//           message:
//               "¿Tienes sugerencias, comentarios o mejoras para la app? Escríbeme directamente por WhatsApp. ¡Estoy para escucharte!",
//           buttonText: "Contactar",
//           onPressed: () {
//             Navigator.pop(context);
//             final whatsappUrl = Uri.parse(
//                 "https://wa.me/51900273862?text=Hola%20Fabricio%2C%20estoy%20usando%20la%20app%20sobre%20San%20Ignacio%2C%20y%20me%20gustar%C3%ADa%20comentarte%20algo.");
//             launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
//           },
//         );
//         break;

//       case 6:
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return AcercaDeLosIntegrantesView(
//             categoryName: 'Acerca de los Integrantes',
//             categoryDescription:
//                 'En este apartado podrás conocer a los integrantes del equipo completo para el desarrollo de este proyecto.',
//             integrantes: integrantesDelEquipo,
//           );
//         }));
//         break;

//       case 7:
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return CuestionesFrecuentesView(
//             categoryName: 'Acerca de Sil Kausay',
//             categoryDescription: 'Aprende cómo comenzar a usar la aplicación, haz preguntas y deja comentarios.',
//             cuestiones: acercaDeLaAplicacion,
//           );
//         }));
//         break;

//       case 8:
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return CuestionesFrecuentesView(
//             categoryName: 'Medidas de Seguridad',
//             categoryDescription: 'Aprende cómo comenzar a usar la aplicación, haz preguntas y deja comentarios.',
//             cuestiones: medidasDeSeguridad,
//           );
//         }));
//         break;

//       case 9:
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return CuestionesFrecuentesView(
//             categoryName: 'Recomendaciones Turísticas',
//             categoryDescription: 'Aprende cómo comenzar a usar la aplicación, haz preguntas y deja comentarios.',
//             cuestiones: recomendacionesTuristicas,
//           );
//         }));
//         break;

//       case 10:
//         validationMessajeDialog(
//           context: context,
//           title: "¿Te gusta lo que hacemos?",
//           message:
//               "Este proyecto sobre San Ignacio esta hecho con mucho esfuerzo y dedicación. Si deseas apoyarnos, puedes invitarnos un cafecito. ¡Cada aporte cuenta!",
//           buttonText: "Invitar un café",
//           onPressed: () {
//             Navigator.pop(context);
//             //TODO: ← Reemplaza con tu link real
//             final url = Uri.parse("https://www.buymeacoffee.com/tulink");
//             launchUrl(url, mode: LaunchMode.externalApplication);
//           },
//         );
//         break;

//       default:
//         break;
//     }
//   }

//   void showMyDataDialog({
//     required BuildContext context,
//     required String username,
//   }) {
//     final TextEditingController usernameController = TextEditingController(text: username);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Editar Datos", textAlign: TextAlign.center),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: usernameController,
//                 decoration: const InputDecoration(
//                   labelText: "Username",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: const Text("Cancelar"),
//               onPressed: () => Navigator.pop(context),
//             ),
//             ElevatedButton(
//               child: const Text("Guardar"),
//               onPressed: () {
//                 final String username = usernameController.text;
//                 debugPrint('Username: $username');
//                 context.read<UsernameCubit>().changeUsername(username);

//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<dynamic> validationMessajeDialog({
//     required BuildContext context,
//     required String title,
//     required String message,
//     required String buttonText,
//     required VoidCallback onPressed,
//   }) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(
//             title,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cerrar"),
//             ),
//             TextButton(
//               onPressed: onPressed,
//               child: Text(
//                 buttonText,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<dynamic> showChangedLanguage({
//     required BuildContext context,
//     required List<String> listElements,
//     required List<MaterialColor> colors,
//     required IconData icon,
//     required String type,
//   }) {
//     return showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       // isScrollControlled: true,
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 16,
//             horizontal: 24,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Text(
//                         'Select your $type',
//                         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 30),
//                 ],
//               ),
//               const Divider(),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: listElements.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: Icon(icon, color: colors[index]),
//                       title: Text(listElements[index]),
//                       onTap: () {
//                         if (type == 'language') {
//                           debugPrint('Select language: ${listElements[index]}');
//                           context.read<LanguageMethodsCubit>().changeLanguage(listElements[index]);
//                         }
//                         Navigator.pop(context);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget siguenosSocialMedia() {
//     return Column(
//       children: [
//         const Text(
//           "Síguenos",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: socialItems
//               .map(
//                 (item) => Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: InkWell(
//                     onTap: () => _launchURL(item.url),
//                     child: SvgPicture.asset(
//                       item.iconPath,
//                       height: 45,
//                       width: 45,
//                     ),
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//       ],
//     );
//   }

//   Future<void> _launchURL(String url) async {
//     final uri = Uri.parse(url);
//     if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//       throw 'No se pudo abrir: $url';
//     }
//   }

//   Widget versionAppAndId() {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           "Versión de la aplicación: 1.3.0\nID:72818492",
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Color(0xff686868),
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }

//   Widget finalMessage() {
//     return const Column(
//       children: [
//         Text(
//           "With 💙 for all Perú",
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 30),
//       ],
//     );
//   }
// }
