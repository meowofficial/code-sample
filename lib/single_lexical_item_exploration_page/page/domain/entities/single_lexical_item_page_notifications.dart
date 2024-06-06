import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/addition_to_collection_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/card_action.dart';
import 'package:mobile_app.core/core/domain/entities/card_actions/mistake_report_card_action.dart';
import 'package:mobile_app.core/core/domain/entities/email_app.dart';
import 'package:mobile_app.core/core/domain/entities/learning_content/lexical_item/lexical_item.dart';
import 'package:mobile_app.core/core/domain/entities/payment_mechanism.dart';

sealed class SingleLexicalItemPageNotification {}

class PurchasePageOpeningNotification extends Equatable
    implements SingleLexicalItemPageNotification {
  const PurchasePageOpeningNotification({
    required this.paymentMechanism,
  });

  final PaymentMechanism paymentMechanism;

  @override
  List<Object?> get props {
    return [
      paymentMechanism,
    ];
  }
}

class UsedCustomLexicalItemDeletionConfirmationDialogOpeningNotification extends Equatable
    implements SingleLexicalItemPageNotification {
  const UsedCustomLexicalItemDeletionConfirmationDialogOpeningNotification();

  @override
  List<Object?> get props => [];
}

class OrphanCustomLexicalItemDeletionConfirmationDialogOpeningNotification extends Equatable
    implements SingleLexicalItemPageNotification {
  const OrphanCustomLexicalItemDeletionConfirmationDialogOpeningNotification();

  @override
  List<Object?> get props => [];
}

class EmailAppSelectionDialogOpeningNotification extends Equatable
    implements SingleLexicalItemPageNotification {
  const EmailAppSelectionDialogOpeningNotification({
    required this.availableEmailApps,
  });

  final BuiltList<EmailApp> availableEmailApps;

  @override
  List<Object?> get props {
    return [
      availableEmailApps,
    ];
  }
}

class MistakeReportMethodSelectionDialogOpeningNotification extends Equatable
    implements SingleLexicalItemPageNotification {
  const MistakeReportMethodSelectionDialogOpeningNotification({
    required this.methods,
  });

  final BuiltList<CardMistakeReportMethod> methods;

  @override
  List<Object?> get props {
    return [
      methods,
    ];
  }
}

class AdditionToCollectionDialogOpeningNotification extends Equatable
    implements SingleLexicalItemPageNotification {
  const AdditionToCollectionDialogOpeningNotification({
    required this.collectionInfos,
  });

  final BuiltList<AdditionToCustomCollectionCardActionCollectionInfo> collectionInfos;

  @override
  List<Object?> get props {
    return [
      collectionInfos,
    ];
  }
}

class CustomLexicalItemEditingDialogOpeningNotification extends Equatable
    implements SingleLexicalItemPageNotification {
  const CustomLexicalItemEditingDialogOpeningNotification({
    required this.lexicalItem,
  });

  final CustomLexicalItem lexicalItem;

  @override
  List<Object?> get props {
    return [
      lexicalItem,
    ];
  }
}

class CardActionDialogOpeningNotification extends Equatable
    implements SingleLexicalItemPageNotification {
  const CardActionDialogOpeningNotification({
    required this.cardActions,
  });

  final BuiltList<CardAction> cardActions;

  @override
  List<Object?> get props {
    return [
      cardActions,
    ];
  }
}
