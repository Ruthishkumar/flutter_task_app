// import 'package:json_annotation/json_annotation.dart';
//
// part 'crypto_price_model.g.dart';
//
// @JsonSerializable()
// class CryptoPriceModel {
//   BitCoinModel bitcoin;
//   EthereumModel ethereum;
//   BitCoinModel tether;
//
//   CryptoPriceModel(this.bitcoin, this.ethereum, this.tether);
//
//   factory CryptoPriceModel.fromJson(Map<String, dynamic> json) =>
//       _$CryptoPriceModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CryptoPriceModelToJson(this);
// }
//
// @JsonSerializable()
// class BitCoinModel {
//   @JsonKey(defaultValue: 0)
//   final int? usd;
//
//   BitCoinModel(this.usd);
//
//   factory BitCoinModel.fromJson(Map<String, dynamic> json) =>
//       _$BitCoinModelFromJson(json);
//   Map<String, dynamic> toJson() => _$BitCoinModelToJson(this);
// }
//
// @JsonSerializable()
// class EthereumModel {
//   @JsonKey(defaultValue: 0.0)
//   final double? usd;
//
//   EthereumModel(this.usd);
//
//   factory EthereumModel.fromJson(Map<String, dynamic> json) =>
//       _$EthereumModelFromJson(json);
//   Map<String, dynamic> toJson() => _$EthereumModelToJson(this);
// }
