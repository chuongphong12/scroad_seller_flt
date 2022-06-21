part of 'auction_bloc.dart';

abstract class AuctionState extends Equatable {
  const AuctionState();

  @override
  List<Object> get props => [];
}

class AuctionInitial extends AuctionState {}

class AuctionLoading extends AuctionState {}

class AuctionLoaded extends AuctionState {
  final List<AuctionModel> auctions;

  const AuctionLoaded({required this.auctions});

  @override
  List<Object> get props => [auctions];
}

class AuctionError extends AuctionState {
  final String message;

  const AuctionError({required this.message});

  @override
  List<Object> get props => [message];
}
