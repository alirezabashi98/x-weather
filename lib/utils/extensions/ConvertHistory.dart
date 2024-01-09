extension ConvertHistory on String {
  String getHoursFromTheWholeDate() {
    var allDate = split(' ');
    var theWatch = allDate[1].split(':');
    var amOrPm = int.parse(theWatch[0]) > 12 ? 'PM' : 'AM';
    return '${theWatch[0]} $amOrPm';
  }
}
