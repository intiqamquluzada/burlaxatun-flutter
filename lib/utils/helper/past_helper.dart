class PastHelper {
  static String timeAgo(String dateString) {
    final now = DateTime.now();
    final date = DateTime.parse(dateString).toLocal();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) {
      return 'just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} dq';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} saat';
    } else if (diff.inDays < 30) {
      return '${diff.inDays} gün${diff.inDays == 1 ? '' : ''}';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '$months ay';
    } else {
      final years = (diff.inDays / 365).floor();
      return '$years il';
    }
  }
}
