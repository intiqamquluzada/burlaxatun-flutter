// lib/helpers/time_helper.dart

String timeAgo(DateTime createdAt) {
  final now = DateTime.now();
  final difference = now.difference(createdAt);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} saniyə öncə';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} dəqiqə öncə';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} saat öncə';
  } else if (difference.inDays == 1) {
    return 'dünən';
  } else {
    return '${difference.inDays} gün öncə';
  }
}
