enum ErrorType{
unauthorized,
userNotFound,
internalError,
refreshTokenFailed,
tokenNotFound,
tokenExpired,
unknown;
}


class ErrorManager {

errorStringCode(error){
switch(error){
case ErrorType.unauthorized:
return "unauthorized";
case ErrorType.userNotFound:
return "user-not-found";
case ErrorType.internalError:
return "internal-server-error";
case ErrorType.refreshTokenFailed:
return "refresh-token-failed";
case ErrorType.tokenNotFound:
return "token-not-found";
case ErrorType.tokenExpired:
return "token-expired";
default:
return "unknown";
}
}

errorStatusCode(error){
switch(error){
case ErrorType.unauthorized:
return 400;
case ErrorType.userNotFound:
return 404;
case ErrorType.internalError:
return 500;
case ErrorType.refreshTokenFailed:
return 403;
case ErrorType.tokenNotFound:
return 403;
case ErrorType.tokenExpired:
return 403;
default:
return 402;
}
}

throwError(res) {
res.status(errorStatusCode).send(errorStringCode);
}

}