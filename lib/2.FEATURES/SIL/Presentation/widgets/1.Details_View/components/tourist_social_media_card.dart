import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../1.CONFIG/Core/utils/enum_social_media_type.dart';

class TouristSocialMediaCard extends StatelessWidget {
  final String? phoneNumber;
  final Map<EnumSocialMediaType, String>? socialMediaLinks;

  const TouristSocialMediaCard({
    super.key,
    this.phoneNumber,
    this.socialMediaLinks,
  });

  @override
  Widget build(BuildContext context) {
    final iconMap = {
      EnumSocialMediaType.facebookUrl: FontAwesomeIcons.facebookF,
      EnumSocialMediaType.instagramUrl: FontAwesomeIcons.instagram,
      EnumSocialMediaType.whatsappUrl: FontAwesomeIcons.whatsapp,
      EnumSocialMediaType.tiktokUrl: FontAwesomeIcons.tiktok,
      EnumSocialMediaType.youtubeUrl: FontAwesomeIcons.youtube,
    };

    final List<Widget> socialIcons = [];

    socialMediaLinks?.forEach((type, url) {
      final icon = iconMap[type];
      if (icon != null && url.isNotEmpty) {
        socialIcons.add(_socialIcon(icon, url));
      }
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Contáctalos:", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              phoneNumber != null
                  ? GestureDetector(
                      onTap: () => launchUrl(Uri.parse("tel:$phoneNumber")),
                      child: Row(
                        children: [
                          const Icon(Icons.call, size: 18, color: Colors.green),
                          const SizedBox(width: 6),
                          Text(
                            phoneNumber!,
                            style: const TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    )
                  : const Text(
                      "No cuenta con un número.",
                      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                    ),
              const SizedBox(height: 16),
              const Text("Redes Sociales:", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              socialIcons.isNotEmpty
                  ? Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20, // espacio horizontal entre íconos
                        runSpacing: 10, // espacio vertical si salta de línea
                        children: socialIcons,
                      ),
                    )
                  : const Text(
                      "Este lugar aún no cuenta con redes sociales.",
                      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.green.withOpacity(0.3),
        onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FaIcon(icon, size: 30, color: Colors.green.withOpacity(0.8)),
        ),
      ),
    );
  }
}
