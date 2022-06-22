import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scroad_seller_flutter/models/auction_model.dart';

part 'auction_event.dart';
part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  AuctionBloc() : super(AuctionInitial()) {
    on<InitializeAuction>(_onInitAuction);
    on<AddAuction>(_onAddAuction);
    on<UpdateAuctionStatus>(_onUpdateAuctionStatus);
  }

  void _onInitAuction(
      InitializeAuction event, Emitter<AuctionState> emit) async {
    emit(AuctionLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(const AuctionLoaded(auctions: []));
  }

  void _onAddAuction(AddAuction event, Emitter<AuctionState> emit) {
    try {
      final List<AuctionModel> auctions = (state as AuctionLoaded).auctions;
      emit(
        AuctionLoaded(
          auctions: List.from(auctions)..add(event.auction),
        ),
      );
    } catch (e) {
      emit(AuctionError(message: e.toString()));
    }
  }

  void _onUpdateAuctionStatus(
      UpdateAuctionStatus event, Emitter<AuctionState> emit) {
    print('UpdateAuctionStatusEvent');
  }
}
