package ai.threeeye.yeyak.common.define;

import lombok.Getter;

@Getter
public enum ApiErrorCode {

    INVALID_PARAMETER(400, "api.error.invalid_parameter", "Invalid parameter."),

    PAGE_NOT_FOUND(404, "api.error.page_not_found", "Page not found."),

    METHOD_NOT_ALLOWED(405, "api.error.method_not_allowed", "Method not allowed."),

    CLIENT_ABORT(499, "api.error.client_abort", "Client abort."),

    //Device
    DEVICE_NOT_FOUND(404, "api.error.device_not_found", "Device not found."),

    DEVICE_ALREADY_EXISTS(400, "api.error.device_already_exists", "Device already exists."),

    // User
    USER_NOT_FOUND(404, "api.error.user_not_found", "User not found."),

    // Reservation
    ALREADY_RESERVED_DEVICE(400, "api.error.already_reserved_device", "Already reserved device."),

    //Common
    NOT_AVAILABLE(400, "api.error.not_available", "not available."),

    UNKNOWN(500, "api.error.unknown", "Unknown error.");

    ApiErrorCode(int status, String code, String msg) {
        this.status = status;
        this.code = code;
        this.msg = msg;
    }

    private final int status;
    private final String code;
    private final String msg;
}
