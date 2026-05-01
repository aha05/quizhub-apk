import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/features/home/domain/entities/home_data.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, HomeData>> fetchHomeData();
}
