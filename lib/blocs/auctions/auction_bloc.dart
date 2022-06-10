import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scroad_seller_flutter/models/auction_model.dart';

part 'auction_event.dart';
part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  AuctionBloc() : super(AuctionLoading()) {
    on<AddPlateNumberEvent>(_onAddPlateNumber);
    on<AddImagesEvent>(_onAddImages);
    on<LoadAuctionEvent>(_onLoadAuction);
    on<UpdateAuctionStatusEvent>(_onUpdateAuctionStatus);
  }

  void _onAddPlateNumber(
      AddPlateNumberEvent event, Emitter<AuctionState> emit) async {
    final AuctionModel auction = (state as AuctionLoaded).auction;
    try {
      emit(AuctionLoading());
      emit(
        AuctionLoaded(
          auction: auction.copyWith(plateNumber: event.plateNumber),
        ),
      );
    } catch (e) {
      emit(AuctionError());
    }
  }

  void _onAddImages(AddImagesEvent event, Emitter<AuctionState> emit) {
    print('AddImagesEvent');
  }

  void _onLoadAuction(LoadAuctionEvent event, Emitter<AuctionState> emit) {
    print('LoadAuctionEvent');
  }

  void _onUpdateAuctionStatus(
      UpdateAuctionStatusEvent event, Emitter<AuctionState> emit) {
    print('UpdateAuctionStatusEvent');
  }
}
