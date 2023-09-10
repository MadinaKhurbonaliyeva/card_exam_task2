import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/cards_model.dart';
import '../data/repository/user_card_repository.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc({required this.cardsRepository})
      : super(const CardState()) {
    on<AddCardEvent>(_addCard);
    on<UpdateCardEvent>(_updateCard);
    on<DeleteCardEvent>(_deleteCard);
  }

  final UserCardsRepository cardsRepository;

  _addCard(AddCardEvent event, Emitter<CardState> emit) async {
    emit(state.copyWith(status: CardStateStatus.loading));
    cardsRepository.addCard(cardModel: event.cardModel);
    emit(state.copyWith(status: CardStateStatus.cardAdded));
  }

  _updateCard(UpdateCardEvent event, Emitter<CardState> emit) async {
    emit(state.copyWith(status: CardStateStatus.loading));
    cardsRepository.updateCard(cardModel: event.cardModel);
    emit(state.copyWith(status: CardStateStatus.cardUpdated));
  }

  _deleteCard(DeleteCardEvent event, Emitter<CardState> emit) async {
    emit(state.copyWith(status: CardStateStatus.loading));
    cardsRepository.deleteCard(docId: event.cardId);
    emit(state.copyWith(status: CardStateStatus.cardDeleted));
  }
}