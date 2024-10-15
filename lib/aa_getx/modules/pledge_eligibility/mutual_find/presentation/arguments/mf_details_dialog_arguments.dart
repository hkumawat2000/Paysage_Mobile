import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/isin_details_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/mf_scheme_response_entity.dart';

class MfDetailsDialogArguments {
  List<SchemesListEntity> selectedSchemeList = [];
  SchemesListEntity scheme;
  List<IsinDetailsResponseEntity>? isinDetails;
  String? schemeType;
  String? lender;
  String? selectedUnit;
  List<SchemesListEntity> schemeListItems;

  MfDetailsDialogArguments({
    required this.selectedSchemeList,
    required this.scheme,
    required this.isinDetails,
    required this.schemeType,
    required this.lender,
    required this.selectedUnit,
    required this.schemeListItems,
  });
}
