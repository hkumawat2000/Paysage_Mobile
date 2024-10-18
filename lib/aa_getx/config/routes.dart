import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lms/aa_getx/modules/account_settings/presentation/bindings/account_settings_bindings.dart';
import 'package:lms/aa_getx/modules/account_settings/presentation/views/account_settings_screen.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/presentation/bindings/approved_securities_list_bindings.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/presentation/bindings/approved_shares_and_mf_bindings.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/presentation/views/approved_securities_view.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/presentation/views/approved_shares_view.dart';
import 'package:lms/aa_getx/modules/account_statement/presentation/views/loan_statement_view.dart';
import 'package:lms/aa_getx/modules/bank/presentation/bindings/add_bank_binding.dart';
import 'package:lms/aa_getx/modules/bank/presentation/views/add_bank_view.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/bindings/cibil_binding.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/bindings/cibil_otp_binding.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/bindings/cibil_result_binding.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/views/cibil_otp_view.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/views/cibil_result_view.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/views/cibil_view.dart';
import 'package:lms/aa_getx/modules/contact_us/presentation/bindings/contact_us_binding.dart';
import 'package:lms/aa_getx/modules/contact_us/presentation/bindings/contact_us_thank_you_binding.dart';
import 'package:lms/aa_getx/modules/contact_us/presentation/views/contact_us_thank_you_view.dart';
import 'package:lms/aa_getx/modules/contact_us/presentation/views/contact_us_view.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/bindings/dashboard_bindings.dart';
import 'package:lms/aa_getx/modules/aml_check/presentation/bindings/aml_check_binding.dart';
import 'package:lms/aa_getx/modules/aml_check/presentation/views/aml_check_view.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/views/dashboard_view.dart';
import 'package:lms/aa_getx/modules/feedback/presentation/bindings/feedback_binding.dart';
import 'package:lms/aa_getx/modules/feedback/presentation/views/feedback_view.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/bindings/kyc_address_bindings.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/bindings/kyc_bindings.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/bindings/kyc_consent_bindings.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/screens/kyc_address_screen.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/screens/kyc_consent_screen.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/screens/kyc_screen.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/forgot_pin_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/login_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/pin_screen_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/terms_and_condition_webview_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/verify_otp_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/forgot_pin_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/login_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/offline_customer_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/otp_verify_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/pin_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/terms_and_conditions_webview.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/mf_send_otp_response_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/bindings/fetch_mutual_fund_binding.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/bindings/mutual_fund_consent_binding.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/bindings/mutual_fund_otp_binding.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/views/fetch_mutual_fund_view.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/views/mutual_fund_consent_view.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/views/mutual_fund_otp_view.dart';
import 'package:lms/aa_getx/modules/more/presentation/bindings/more_bindings.dart';
import 'package:lms/aa_getx/modules/more/presentation/views/more_view.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/bindings/margin_shortfall_binding.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/bindings/margin_shortfall_eligible_dialog_binding.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/bindings/margin_shortfall_pledge_otp_binding.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/bindings/single_my_active_loan_binding.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/views/application_success_view.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/views/application_top_up_success_view.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/views/margin_shortfall_eligible_dialog_view.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/views/margin_shortfall_pledge_otp_view.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/views/margin_shortfall_view.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/views/single_my_active_loan_view.dart';
import 'package:lms/aa_getx/modules/notification/presentation/bindings/notification_binding.dart';
import 'package:lms/aa_getx/modules/notification/presentation/views/notification_view.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/bindings/splash_binding.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/jail_break_view.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/splash_view.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/bindings/enable_fingerprint_dialog_binding.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/bindings/fingerprint_binding.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/views/enable_fingerprint_dialog_view.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/views/fingerprint_view.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/walkthrough_view.dart';
import 'package:lms/aa_getx/modules/payment/presentation/bindings/payment_binding.dart';
import 'package:lms/aa_getx/modules/payment/presentation/views/payment_view.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/presentation/bindings/pledge_mf_bindings.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/presentation/views/mf_view_vault_details_view.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/presentation/views/pledge_mf_scheme_selection_view.dart';
import 'package:lms/aa_getx/modules/pledged_securities/presentation/bindings/my_pledge_security_binding.dart';
import 'package:lms/aa_getx/modules/pledged_securities/presentation/views/my_pledge_security_view.dart';
import 'package:lms/aa_getx/modules/pledged_securities/presentation/views/my_pledged_transactions_view.dart';
import 'package:lms/aa_getx/modules/registration/presentation/bindings/offline_customer_binding.dart';
import 'package:lms/aa_getx/modules/registration/presentation/bindings/registration_binding.dart';
import 'package:lms/aa_getx/modules/registration/presentation/bindings/set_pin_binding.dart';
import 'package:lms/aa_getx/modules/registration/presentation/views/offline_customer_screen.dart';
import 'package:lms/aa_getx/modules/registration/presentation/views/registration_successful_view.dart';
import 'package:lms/aa_getx/modules/registration/presentation/views/registration_view.dart';
import 'package:lms/aa_getx/modules/registration/presentation/views/set_pin_view.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/bindings/mf_invoke_binding.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/bindings/sell_collateral_binding.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/views/mf_invoke_view.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/views/sell_collateral_success_view.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/views/sell_collateral_view.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/bindings/mf_revoke_binding.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/bindings/unpledge_shares_binding.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/views/mf_revoke_view.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/views/unpledge_shares_view.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/views/unpledge_successful_view.dart';
import 'package:lms/aa_getx/modules/risk_profile/presentation/bindings/risk_profile_binding.dart';
import 'package:lms/aa_getx/modules/risk_profile/presentation/views/risk_profile_view.dart';
import 'package:lms/aa_getx/modules/webview/presentation/binding/common_webview_binding.dart';
import 'package:lms/aa_getx/modules/webview/presentation/views/common_webview_view.dart';

const String splashView = "splash-view";
const String jailBreakView = "jail-break-view";
const String pinView = "pin-view";
const String loginView = "login-view";
const String tutorialsView = "tutorials-view";
const String offlineCustomerView = "offline-customer-view";
const String termsAndConditionsWebView = "terms-and-condition-web-view";
const String otpVerificationView = "otp-verification-view";
const String pinScreen = "pin-view";
const String setPinView = "set-pin-view";
const String forgotPinView = "forgot-pin-view";
const String registrationView = "registration-view";
const String fingerPrintView = "fingerprint-view";
const String enableFingerPrintView = "enable-fingerprint-view";
const String registrationSuccessfulView = "registration-successful-view";
const String kycView = "kyc-view";
const String kycConsentView = "kyc-conset-view";
const String kycAddressView = "kyc-address-view";
const String youtubeVideoPlayer = "youtube-video-player";
const String notificationView = "notification-view";
const String moreView = "more-view";
const String singleMyActiveLoanView = "single-my-active-loan-view";
const String applicationTopUpSuccessView = "application-top-Up-success-view";
const String applicationSuccessView = "application-success-view";
const String marginShortfallView = "margin-shortfall-view";
const String dashboardView = "dashboard-view";
const String commonWebview = "common-webview";
const String amlCheckView = "aml-check--view";
const String marginShortfallPledgeOTPView = "margin-shortfall-pledge-otp-view";
const String marginShortfallEligibleDialogView =
    "margin-shortfall-eligible-dialog-view";
const String myPledgedSecuritiesView = "my-pledged-securities-view";
const String accountSettingsView = "account-settings-view";
const String approvedSharesView = "approved-shares-view";
const String paymentView = "payment-view";
const String loanStatementView = "loan-statement-view";
const String addBank = "add-bank";
const String downloadStatementView = "download-statement-view";
const String cibilView = "cibil-view";
const String cibilResultView = "cibil-result-view";
const String cibilOtpView = "cibil-otp-view";
const String myPledgedTransactionsView = "my-pledged-transactions-view";
const String sellCollateralView = "sell-collateral-view";
const String sellCollateralSuccessView = "sell-collateral-success-view";
const String mfInvokeView = "mf-invoke-view";
const String mutualFundConsentView = "mutual-fund-consent-view";
const String fetchMutualFundView = "fetch-mutual-fund-view";
const String mutualFundOtpView = "mutual-fund-otp-view";
const String riskProfileView = "risk-profile-view";
LoginSubmitResquestEntity? loginSubmitRequestEntity;
// const String sellCollateralView = "sell-collateral-view";
// const String sellCollateralSuccessView = "sell-collateral-success-view";
// const String mfInvokeView = "mf-invoke-view";
const String mfRevokeView = "mf-revoke-view";
const String unpledgeSuccessfulView = "unpledge-successful-view";
const String unpledgeSharesView = "unpledge-shares-view";
const String contactUsView = "contact-us-view";
const String contactUsThankYouView = "contact-us-thank-you-view";
const String feedbackView = "feedback-view";
const String pledgeMfSchemeSelection = "pledge-mf-scheme-selection";
const String mfViewVaultDetailsScreen = "mf-view-vault-details-screen";
const String approvedSecuritiesView = "approved-shares-view";
LoginSubmitResquestEntity? loginSubmitResquestEntity;

List<GetPage> routes = [
  GetPage(
    name: '/$splashView',
    page: () => SplashView(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: '/$jailBreakView',
    page: () => JailBreakView(),
  ),
  GetPage(
    name: '/$pinView',
    page: () => PinScreenView(),
    binding: PinScreenBindings(),
  ),
  GetPage(
    name: '/$forgotPinView',
    page: () => ForgotPinScreen(),
    binding: ForgotPinBindings(),
  ),
  GetPage(
    name: '/$loginView',
    page: () => LoginView(),
    binding: LoginBindings(),
  ),
  GetPage(name: '/$tutorialsView', page: () => WalkthroughScreen()),
  GetPage(name: '/$offlineCustomerView', page: () => OfflineCustomerScreen()),
  GetPage(
    name: '/$termsAndConditionsWebView',
    page: () => TermsAndConditionsWebview(),
    binding: TermsAndConditionWebviewBindings(),
  ),
  GetPage(
    name: '/$otpVerificationView',
    page: () => OTPVerificationView(
      loginSubmitResquestEntity: loginSubmitResquestEntity!,
    ),
    binding: VerifyOtpBindings(),
  ),
  GetPage(
    name: '/$setPinView',
    page: () => SetPinView(),
    binding: SetPinBinding(),
  ),
  GetPage(
    name: '/$offlineCustomerView',
    page: () => OfflineCustomerView(),
    binding: OfflineCustomerBinding(),
  ),
  GetPage(
    name: '/$registrationView',
    page: () => RegistrationView(),
    binding: RegistrationBinding(),
  ),
  GetPage(
    name: '/$fingerPrintView',
    page: () => FingerPrintView(),
    binding: FingerprintBinding(),
  ),
  GetPage(
    name: '/$enableFingerPrintView',
    page: () => EnableFingerPrintDialog(),
    binding: EnableFingerprintBinding(),
  ),
  GetPage(
    name: '/$registrationSuccessfulView',
    page: () => RegistrationSuccessfulView(),
  ),
  GetPage(
    name: '/$kycView',
    page: () => CompleteKycView(),
    binding: KycBindings(),
  ),
  GetPage(
    name: '/$kycConsentView',
    page: () => KycConsentScreen(),
    binding: KycConsentBindings(),
  ),
  GetPage(
    name: '/$kycAddressView',
    page: () => KycAddressScreen(),
    binding: KycAddressBindings(),
  ),
  // GetPage(
  //   name: '/$youtubeVideoPlayer',
  //   page: () => YoutubeVideoPlayerView(),
  // ),
  GetPage(
    name: '/$notificationView',
    page: () => NotificationView(),
    binding: NotificationBinding(),
  ),
  GetPage(
    name: '/$moreView',
    page: () => MoreView(),
    binding: MoreBinding(),
  ),
  GetPage(
    name: '/$singleMyActiveLoanView',
    page: () => SingleMyActiveLoanView(),
    binding: SingleMyActiveLoanBinding(),
  ),
  GetPage(
    name: '/$applicationTopUpSuccessView',
    page: () => ApplicationTopUpSuccessView(),
  ),
  GetPage(
    name: '/$applicationSuccessView',
    page: () => ApplicationSuccessView(),
  ),
  GetPage(
    name: '/$dashboardView',
    page: () => DashboardView(),
    binding: DashboardBindings(),
  ),
  GetPage(
    name: '/$commonWebview',
    page: () => CommonWebviewView(),
    binding: CommonWebviewBinding(),
  ),
  GetPage(
    name: '/$marginShortfallView',
    page: () => MarginShortfallView(),
    binding: MarginShortfallBinding(),
  ),
  GetPage(
    name: '/$marginShortfallPledgeOTPView',
    page: () => MarginShortfallPledgeOTPView(),
    binding: MarginShortfallPledgeOtpBinding(),
  ),
  GetPage(
    name: '/$marginShortfallEligibleDialogView',
    page: () => MarginShortfallEligibleDialogView(),
    binding: MarginShortfallEligibleDialogBinding(),
  ),
  GetPage(
    name: '/$amlCheckView',
    page: () => AmlCheckView(),
    binding: AmlCheckBinding(),
  ),
  GetPage(
    name: '/$myPledgedSecuritiesView',
    page: () => MyPledgeSecurityView(),
    binding: MyPledgeSecurityBinding(),
  ),
  GetPage(
    name: '/$accountSettingsView',
    page: () => AccountSettingsView(),
    binding: AccountSettingsBindings(),
  ),
  GetPage(
    name: '/$paymentView',
    page: () => PaymentView(),
    binding: PaymentBinding(),
  ),
  GetPage(
    name: '/$loanStatementView',
    page: () => LoanStatementView(),
  ),
  GetPage(
    name: '/$addBank',
    page: () => AddBankView(),
    binding: AddBankBinding(),
  ),
  // GetPage(
  //   name: '/$downloadStatementView',
  //   page: () => DownloadStatementView(loanName, isComingFrom, tabController),
  //   binding: DownloadStatementBinding(),
  // ),
  GetPage(
    name: '/$cibilView',
    page: () => CibilView(),
    binding: CibilBinding(),
  ),
  GetPage(
    name: '/$cibilResultView',
    page: () => CibilResultView(),
    binding: CibilResultBinding(),
  ),
  GetPage(
    name: '/$cibilOtpView',
    page: () => CibilOtpView("", "", "", ""),
    binding: CibilOtpBinding(),
  ),
  GetPage(
    name: '/$myPledgedTransactionsView',
    page: () => MyPledgedTransactionsView(),
  ),
  GetPage(
    name: '/$approvedSharesView',
    page: () => ApprovedSharesView(),
    binding: ApprovedSharesAndMfBindings(),
  ),
  GetPage(
    name: '/$sellCollateralView',
    page: () => SellCollateralView(),
    binding: SellCollateralBinding(),
  ),
  GetPage(
    name: '/$sellCollateralSuccessView',
    page: () => SellCollateralSuccessView(),
  ),
  GetPage(
    name: '/$mfInvokeView',
    page: () => MfInvokeView(),
    binding: MfInvokeBinding(),
  ),
  GetPage(
    name: '/$mutualFundConsentView',
    page: () => MutualFundConsentView(),
    binding: MutualFundConsentBinding(),
  ),
  GetPage(
    name: '/$fetchMutualFundView',
    page: () => FetchMutualFundView(),
    binding: FetchMutualFundBinding(),
  ),
  GetPage(
    name: '/$mutualFundOtpView',
    page: () => MutualFundOtpView(MutualFundSendOtpDataEntity()),
    binding: MutualFundOtpBinding(),
  ),
  GetPage(
    name: '/$riskProfileView',
    page: () => RiskProfileView(),
    binding: RiskProfileBinding(),
  ),
  GetPage(
    name: '/$sellCollateralView',
    page: () => SellCollateralView(),
    binding: SellCollateralBinding(),
  ),
  GetPage(
    name: '/$sellCollateralSuccessView',
    page: () => SellCollateralSuccessView(),
  ),
  GetPage(
    name: '/$mfInvokeView',
    page: () => MfInvokeView(),
    binding: MfInvokeBinding(),
  ),
  GetPage(
    name: '/$contactUsView',
    page: () => ContactUsView(),
    binding: ContactUsBinding(),
  ),
  GetPage(
    name: '/$contactUsThankYouView',
    page: () => ContactUsThankYouView(),
    binding: ContactUsThankYouBinding(),
  ),
  GetPage(
    name: '/$feedbackView',
    page: () => FeedbackView(),
    binding: FeedbackBinding(),
  ),
  // GetPage(
  //   name: '/$mfRevokeView',
  //   page: () => MfRevokeView(),
  //   binding: MfRevokeBinding(),
  // ),
  // GetPage(
  //   name: '/$unpledgeSuccessfulView',
  //   page: () => UnpledgeSuccessfulView(),
  // ),
  // GetPage(
  //   name: '/$unpledgeSharesView',
  //   page: () => UnpledgeSharesView(),
  //   binding: UnpledgeSharesBinding(),
  // ),
//PLedge MF Scheme Selection
  GetPage(
    name: '/$pledgeMfSchemeSelection',
    page: () => PledgeMfSchemeSelectionView(),
    binding: PledgeMfBindings(),
  ),
  //
   GetPage(
    name: '/$mfViewVaultDetailsScreen',
    page: () => MfViewVaultDetailsView(),
  ),
  //ApprovedSecuritiesView
  GetPage(
    name: '/$approvedSecuritiesView',
    page: () => ApprovedSecuritiesView(),
    binding: ApprovedSecuritiesListBindings(),
  ),
];
