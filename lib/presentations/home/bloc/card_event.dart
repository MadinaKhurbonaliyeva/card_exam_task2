part of 'card_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();
}

class AddCardEvent extends CardEvent {
  final UserCard cardModel;

  const AddCardEvent({required this.cardModel});

  @override
  List<Object?> get props => [cardModel];
}

class UpdateCardEvent extends CardEvent {
  final UserCard cardModel;

  const UpdateCardEvent({required this.cardModel});

  @override
  List<Object?> get props => [cardModel];
}

class DeleteCardEvent extends CardEvent {
  final String cardId;

  const DeleteCardEvent({required this.cardId});

  @override
  List<Object?> get props => [cardId];
}