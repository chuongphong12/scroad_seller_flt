part of 'auction_bloc.dart';

abstract class AuctionEvent extends Equatable {
  const AuctionEvent();

  @override
  List<Object> get props => [];
}

class InitializeAuction extends AuctionEvent {}

class AddAuction extends AuctionEvent {
  final AuctionModel auction;

  const AddAuction({required this.auction});

  @override
  List<Object> get props => [auction];
}

class UpdateAuctionStatus extends AuctionEvent {
  final String auctionId;
  final String auctionStatus;

  const UpdateAuctionStatus(
      {required this.auctionId, required this.auctionStatus});

  @override
  List<Object> get props => [auctionId, auctionStatus];
}
