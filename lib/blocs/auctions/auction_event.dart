part of 'auction_bloc.dart';

abstract class AuctionEvent extends Equatable {
  const AuctionEvent();

  @override
  List<Object> get props => [];
}

class InitializeAuctionEvent extends AuctionEvent {}

class AddAuctionEvent extends AuctionEvent {
  final AuctionModel auction;

  const AddAuctionEvent({required this.auction});

  @override
  List<Object> get props => [auction];
}

class LoadAuctionEvent extends AuctionEvent {
  final List<AuctionModel> auctions;

  const LoadAuctionEvent({required this.auctions});

  @override
  List<Object> get props => [auctions];
}

class UpdateAuctionStatusEvent extends AuctionEvent {
  final String auctionId;
  final String auctionStatus;

  const UpdateAuctionStatusEvent(
      {required this.auctionId, required this.auctionStatus});

  @override
  List<Object> get props => [auctionId, auctionStatus];
}
