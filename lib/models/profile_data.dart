class ProfileData {
  const ProfileData({
    required this.name,
    required this.title,
    required this.bio,
  });

  final String name;
  final String title;
  final String bio;

  static const defaults = ProfileData(
    name: 'Fakhry Firdaus',
    title: 'Software Engineer & Dosen',
    bio: 'Suka membangun aplikasi mobile dan berbagi ilmu.',
  );
}
