abstract class Endpoints {
  // Authentication
  static const String login = '/api/v1/login';
  static const String register = '/api/v1/register';
  static const String transaksi = '/api/v1/transaksi/byDompet';
  static const String pemasukan= '/api/v1/transaksi/pemasukan';
  static const String pengeluaran= '/api/v1/transaksi/pengeluaran';
  static const String dompet = '/api/v1/dompet/user';
  static const String addDompet = '/api/v1/dompet';
  static const String profile= '/api/v1/profile';
  static const String profilePicture= '/api/v1/profile/picture';
  static const String changeProfilePicture= '/api/v1/profile//change-picture';

}
