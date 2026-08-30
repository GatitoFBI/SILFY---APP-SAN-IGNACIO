// Lista de redes con su ícono y URL
final List<SocialItem> socialItems = [
  const SocialItem(
    iconPath: 'assets/icons/social_media/instagram.svg',
    url: 'https://www.instagram.com/silfy_project',
  ),
  const SocialItem(
    iconPath: 'assets/icons/social_media/tiktok.svg',
    url: 'https://www.tiktok.com/@silfy_project',
  ),
  const SocialItem(
    iconPath: 'assets/icons/social_media/youtube.svg',
    url: 'https://www.youtube.com/@silfy_project',
  ),
  const SocialItem(
    iconPath: 'assets/icons/social_media/facebook.svg',
    url: 'https://www.facebook.com/profile.php?id=61575632282424',
  ),
  const SocialItem(
    iconPath: 'assets/icons/social_media/reddit.svg',
    url: 'https://www.reddit.com/user/Curious_Account_570/',
  ),
];

class SocialItem {
  final String iconPath;
  final String url;

  const SocialItem({required this.iconPath, required this.url});
}
