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

  String getPlanIntToString(int type) {
    if (type == 0) {
      return 'Wake up plan';
    } else if (type == 1) {
      return 'Sleep plan';
    } else {
      return 'Other plan';
    }
  }
}
