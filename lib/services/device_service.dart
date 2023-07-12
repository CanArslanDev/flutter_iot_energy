// ignore_for_file: public_member_api_docs

class DeviceService {
  String getTypeIntToString(int type) {
    if (type == 1) {
      return 'battery';
    } else if (type == 2) {
      return 'plug';
    } else {
      return 'other';
    }
  }
}
