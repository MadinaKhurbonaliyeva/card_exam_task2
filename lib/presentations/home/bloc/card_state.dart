part of 'card_bloc.dart';

class CardState extends Equatable {
  const CardState({
    this.status = CardStateStatus.initial,
  });

  final CardStateStatus status;

  CardState copyWith({
    CardStateStatus? status,
  }) {
    return CardState(
      status: status ?? CardStateStatus.initial,
    );
  }

  @override
  List<Object?> get props => [
    status,
  ];
}

enum CardStateStatus {
  loading,
  initial,
  cardAdded,
  cardUpdated,
  cardDeleted,
  cardFetched,
}