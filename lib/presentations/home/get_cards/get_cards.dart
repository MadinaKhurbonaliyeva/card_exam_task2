import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/cards_model.dart';
import '../data/repository/user_card_repository.dart';
import 'get_card_state.dart';

class GetCardsCubit extends Cubit<GetCardState> {
  final UserCardsRepository cardsRepository;

  GetCardsCubit({required this.cardsRepository}) : super(GetCardInLoading()) {
    fetchAllCards();
  }

  void fetchAllCards() {
    emit(GetCardInLoading());
    cardsRepository.getAllCards().listen(
          (List<UserCard> cards) {
        emit(GetCardInSuccess(card: cards));
      },
    );
  }
}