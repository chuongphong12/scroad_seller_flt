import 'dart:io';

import 'package:equatable/equatable.dart';

class AuctionModel extends Equatable {
  final String sellerName;
  final String sellerPhoneNumber;
  final String sellerAddress;
  final String sellerCity;
  final String description;
  final String plateNumber;
  final String auctionStatus;
  final List<UploadImage> images;
  const AuctionModel({
    required this.sellerName,
    required this.sellerPhoneNumber,
    required this.sellerAddress,
    required this.sellerCity,
    required this.description,
    required this.plateNumber,
    required this.auctionStatus,
    required this.images,
  });

  AuctionModel copyWith({
    String? sellerName,
    String? sellerPhoneNumber,
    String? sellerAddress,
    String? sellerCity,
    String? description,
    String? plateNumber,
    String? auctionStatus,
    List<UploadImage>? images,
  }) {
    return AuctionModel(
      sellerName: sellerName ?? this.sellerName,
      sellerPhoneNumber: sellerPhoneNumber ?? this.sellerPhoneNumber,
      sellerAddress: sellerAddress ?? this.sellerAddress,
      sellerCity: sellerCity ?? this.sellerCity,
      description: description ?? this.description,
      plateNumber: plateNumber ?? this.plateNumber,
      auctionStatus: auctionStatus ?? this.auctionStatus,
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props {
    return [
      sellerName,
      sellerPhoneNumber,
      sellerAddress,
      sellerCity,
      description,
      plateNumber,
      auctionStatus,
      images,
    ];
  }

  @override
  String toString() {
    return 'AuctionModel(sellerName: $sellerName, sellerPhoneNumber: $sellerPhoneNumber, sellerAddress: $sellerAddress, sellerCity: $sellerCity, description: $description, plateNumber: $plateNumber, auctionStatus: $auctionStatus, images: $images)';
  }

  static const empty = AuctionModel(
    sellerName: '',
    sellerPhoneNumber: '',
    sellerAddress: '',
    sellerCity: '',
    description: '',
    plateNumber: '',
    auctionStatus: '',
    images: [],
  );
}

class UploadImage extends Equatable {
  final File? imageFile;
  final String imageName;

  const UploadImage({
    this.imageFile,
    required this.imageName,
  });

  UploadImage copyWith({
    File? imageFile,
    String? imageName,
  }) {
    return UploadImage(
      imageFile: imageFile ?? this.imageFile,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object> get props => [imageFile!, imageName];
}
