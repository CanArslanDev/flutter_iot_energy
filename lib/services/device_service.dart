class DeviceService {
  String getTypeIntToString(int type) {
    if (type == 0) {
      return 'battery';
    } else if (type == 1) {
      return 'plug';
    } else {
      return 'other';
    }
  }

  int getTypeStringToInt(String type) {
    if (type == 'battery') {
      return 0;
    } else if (type == 'plug') {
      return 1;
    } else {
      return 2;
    }
  }

  String getPlanIntToString(int type) {
    if (type == 0) {
      return 'Wake up plan';
    } else if (type == 1) {
      return 'Sleep plan';
    } else {
      return 'Other plan';
    }
  }

  int getStringToPlan(String plan) {
    if (plan == 'Wake up plan') {
      return 0;
    } else if (plan == 'Sleep plan') {
      return 1;
    } else {
      return 2;
    }
  }

  bool calculateOnlineDevice(DateTime recentTime, DateTime nowTime) {
    if (recentTime.year == nowTime.year &&
        recentTime.month == nowTime.month &&
        recentTime.day == nowTime.day &&
        recentTime.hour == nowTime.hour &&
        nowTime.minute - 2 <= recentTime.minute) {
      return true;
    } else {
      return false;
    }
  }

  bool? getIfRechargable(String type, dynamic charging) {
    if (type == 'plug') {
      return null;
    } else {
      return charging as bool;
    }
  }
}
