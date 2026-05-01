import 'package:fpdart/fpdart.dart';
import 'package:quizhub/core/error/failures.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/home/domain/entities/home_data.dart';
import 'package:quizhub/features/home/domain/repositories/home_repository.dart';

class FetchHomeData implements UseCase<HomeData, NoParams> {
  final HomeRepository homeRepository;

  const FetchHomeData(this.homeRepository);

  @override
  Future<Either<Failure, HomeData>> call(NoParams params) async {
    return await homeRepository.fetchHomeData();
  }
}
