import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scroad_seller_flutter/models/auction_model.dart';

part 'auction_event.dart';
part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  AuctionBloc() : super(AuctionLoading()) {
    on<InitializeAuctionEvent>(_onInitAuction);
    on<AddAuctionEvent>(_onAddAuction);
    on<LoadAuctionEvent>(_onLoadAuctions);
    on<UpdateAuctionStatusEvent>(_onUpdateAuctionStatus);
  }

  void _onInitAuction(
      InitializeAuctionEvent event, Emitter<AuctionState> emit) async {
    emit(const AuctionLoaded(auctions: []));
  }

  void _onAddAuction(AddAuctionEvent event, Emitter<AuctionState> emit) {
    try {
      emit(AuctionLoading());
      add(
        LoadAuctionEvent(
          auctions: [...(state as AuctionLoaded).auctions, event.auction],
        ),
      );
    } catch (e) {
      emit(AuctionError(message: e.toString()));
    }
  }

  void _onLoadAuctions(LoadAuctionEvent event, Emitter<AuctionState> emit) {
    try {
      emit(AuctionLoaded(auctions: event.auctions));
    } catch (e) {
      emit(AuctionError(message: e.toString()));
    }
  }

  void _onUpdateAuctionStatus(
      UpdateAuctionStatusEvent event, Emitter<AuctionState> emit) {
    print('UpdateAuctionStatusEvent');
  }
}
