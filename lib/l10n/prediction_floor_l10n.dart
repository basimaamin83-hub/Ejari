import 'package:ejari/data/rent_price_prediction_mock.dart';
import 'package:ejari/l10n/app_localizations.dart';

extension PredictionFloorL10n on PredictionFloor {
  String localized(AppLocalizations l10n) {
    switch (this) {
      case PredictionFloor.ground:
        return l10n.floorGround;
      case PredictionFloor.first:
        return l10n.floorFirst;
      case PredictionFloor.second:
        return l10n.floorSecond;
      case PredictionFloor.third:
        return l10n.floorThird;
      case PredictionFloor.roof:
        return l10n.floorRoof;
      case PredictionFloor.standaloneVilla:
        return l10n.floorVilla;
    }
  }
}
