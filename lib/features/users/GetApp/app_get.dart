import 'package:get/get.dart';

class AppGet extends GetxController {
  int countNotificationfet = 0;
  int countNotificationfetSp = 0;
  int blocked;
  int term;

  String paymentTitle;
  String paymentDes;
  String onlineTitle;
  String onlineDes;

  setPaymentTitle(String value) {
    this.paymentTitle = value;
  }
  
   setPaymentDes(String value) {
    this.paymentDes = value;
  }

   setOnlineTitle(String value) {
    this.onlineTitle = value;
  }
   setOnlineDes(String value) {
    this.onlineDes = value;
  }
  setTerm(int value) {
    this.term = value;
    update(['term']);
  }

  setCountNotifi(int value) {
    this.countNotificationfet = value;
    update(['notifi']);
  }

  setCountNotifiSp(int value) {
    this.countNotificationfetSp = value;
    // update(['notifi']);
  }

  setBolcked(int value) {
    this.blocked = value;
  }
}
