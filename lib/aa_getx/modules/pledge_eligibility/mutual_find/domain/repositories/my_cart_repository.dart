import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/my_cart_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/my_cart_response_entity.dart';

abstract class MyCartRepository {
  ResultFuture<MyCartResponseEntity> myCart(MyCartRequestEntity myCartRequestEntity);
}