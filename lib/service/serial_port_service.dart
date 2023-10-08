import 'package:quick_usb/quick_usb.dart';

class SerialPortService {
  static void usbTest() async {
    await QuickUsb.init();
    //var deviceList = await QuickUsb.getDevicesWithDescription();
    var deviceList = await QuickUsb.getDeviceList();
    for (var device in deviceList) {
      print(device); //TODO get vendorId and productId of device
      //compare to RtapConfig.vendorId and RtapConfig.ProductId.
    }
    await QuickUsb.exit();
  }
}