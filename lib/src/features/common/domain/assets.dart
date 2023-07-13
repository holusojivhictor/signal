class Assets {
  const Assets._();

  static const String _dbPath = 'assets/db';
  static const String _svgsPath = 'assets/svgs';
  static const String _gifsPath = 'assets/gifs';
  static const String _imagesPath = 'assets/images';

  static String productsPath = '$_dbPath/products.json';

  static const String loading = '$_gifsPath/loading.gif';

  static const String google = '$_svgsPath/google.svg';
  static const String apple = '$_svgsPath/apple.svg';
  static const String notification = '$_svgsPath/notification.svg';
  static const String binance = '$_svgsPath/binance.svg';
  static const String bitcoin = '$_svgsPath/bitcoin.svg';
  static String getSvgPath(String name) => '$_svgsPath/$name';

  static const String profile = '$_imagesPath/profile.png';
  static const String noise = '$_imagesPath/noise.png';
}
