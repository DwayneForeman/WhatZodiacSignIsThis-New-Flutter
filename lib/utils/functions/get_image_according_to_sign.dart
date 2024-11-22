String getImage(String sign) {
  switch (sign.toLowerCase()) {
    case 'aries':
      return 'assets/images/aries.png';
    case 'aquarius':
      return 'assets/images/aquarius.png';
    case 'cancer':
      return 'assets/images/cancer.png';
    case 'capricorn':
      return 'assets/images/capricorn.png';
    case 'gemini':
      return 'assets/images/gemini.png';
    case 'leo':
      return 'assets/images/leo.png';
    case 'libra':
      return 'assets/images/libra.png';
    case 'pisces':
      return 'assets/images/pisces.png';
    case 'sagittarius':
      return 'assets/images/sagittarius.png';
    case 'scorpio':
      return 'assets/images/scorpio.png';
    case 'taurus':
      return 'assets/images/taurus.png';
    case 'virgo':
      return 'assets/images/virgo.png';
    default:
      return 'assets/images/virgo.png';
  }
}