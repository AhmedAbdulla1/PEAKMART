import 'package:freezed_annotation/freezed_annotation.dart';
import 'http_error.dart';

part 'app_errors.freezed.dart';

@freezed
class AppErrors with _$AppErrors {
  @Implements<HttpError>()
  const factory AppErrors.connectionError({@Default("") String message}) = ConnectionError;

  @Implements<HttpError>()
  const factory AppErrors.internalServerError({@Default("") String message}) = InternalServerError;

  @Implements<HttpError>()
  const factory AppErrors.internalServerWithDataError(
    int errorCode, {
    String? message,
  }) = InternalServerWithDataError;

  const factory AppErrors.accountNotVerifiedError({@Default("") String message}) = AccountNotVerifiedError;

  /// BadRequestError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.badRequestError({@Default("") String message}) =
      BadRequestError;

  /// CancelError extends BaseError
  const factory AppErrors.cancelError(String? message) = CancelError;

  /// ConflictError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.conflictError({@Default("") String message}) = ConflictError;

  /// CustomError extends BaseError
  const factory AppErrors.customError({@Default("") String message}) =
      CustomError;

  /// ForbiddenError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.forbiddenError({@ Default("") String message}) = ForbiddenError;

  /// FormatError extends BaseError
  const factory AppErrors.formatError({@Default("") String message}) = FormatError;

  /// LoginRequiredError extends BaseError
  const factory AppErrors.loginRequiredError({@Default("") String message}) = LoginRequiredError;

  /// NetError extends ConnectionError
  @Implements<HttpError>()
  const factory AppErrors.netError({@Default("") String message}) = NetError;

  /// NotFoundError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.notFoundError(String requestedUrlPath) =
      NotFoundError;

  /// ResponseError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.responseError({@Default("") String message}) = ResponseError;

  /// ScreenNotImplementedError extends BaseError
  const factory AppErrors.screenNotImplementedError({@Default("") String message}) =
      ScreenNotImplementedError;

  /// SocketError extends ConnectionError
  @Implements<HttpError>()
  const factory AppErrors.socketError({@Default("") String message}) = SocketError;

  /// TimeoutError extends ConnectionError
  @Implements<HttpError>()
  const factory AppErrors.timeoutError({@Default("") String message}) = TimeoutError;

  /// UnauthorizedError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.unauthorizedError({@Default("") String message}) = UnauthorizedError;

  /// UnknownError extends ConnectionError
  @Implements<HttpError>()
  const factory AppErrors.unknownError({@Default("") String message}) = UnknownError;
}
