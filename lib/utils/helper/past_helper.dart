class PastHelper {
  static String timeAgo(String dateString) {
    final now = DateTime.now();
    final date =
        DateTime.parse(dateString).toLocal(); // Zaman dilimi düzeltmesi
    final diff = now.difference(date);

    if (diff.inMinutes < 1) {
      return 'just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} dq öncə';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} saat öncə';
    } else if (diff.inDays < 30) {
      return '${diff.inDays} gün${diff.inDays == 1 ? '' : ''} öncə';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '$months ay öncə';
    } else {
      final years = (diff.inDays / 365).floor();
      return '$years il öncə';
    }
  }
}
