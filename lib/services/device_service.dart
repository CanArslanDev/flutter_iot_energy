// ignore_for_file: public_member_api_docs

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
}
