import 'package:data/api/ball_score/ball_score_model.dart';

extension BallScoreModelBoolean on BallScoreModel? {
  bool? isLegalDelivery() {
    if (this == null) {
      return null;
    }
    return this!.extras_type != ExtrasType.penaltyRun &&
        this!.extras_type != ExtrasType.noBall &&
        this!.extras_type != ExtrasType.wide &&
        this!.wicket_type != WicketType.timedOut &&
        this!.wicket_type != WicketType.retired &&
        this!.wicket_type != WicketType.retiredHurt;
  }
}