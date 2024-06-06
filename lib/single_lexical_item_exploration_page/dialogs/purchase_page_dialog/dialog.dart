import 'package:mobile_app.core/core/domain/entities/payment_mechanism.dart';
import 'package:mobile_app.core/core/presentation/helpers/show_dialogs.dart';
import 'package:mobile_app.core/pages/app_store_purchase_page/page/presentation/page.dart';
import 'package:mobile_app.core/pages/google_play_purchase_page/page/presentation/page.dart';
import 'package:mobile_app.core/pages/web_purchase_page/page/presentation/page.dart';

void showPurchasePageDialog({
  required PaymentMechanism paymentMechanism,
}) {
  showAppFullscreenModal(
    builder: (context) {
      switch (paymentMechanism) {
        case PaymentMechanism.appStore:
          return const AppStorePurchasePage();

        case PaymentMechanism.googlePlay:
          return const GooglePlayPurchasePage();

        case PaymentMechanism.web:
          return const WebPurchasePage();
      }
    },
    enableDrag: false,
  );
}
