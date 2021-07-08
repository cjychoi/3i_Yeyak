package ai.threeeye.yeyak.common.define;

import lombok.Getter;

@Getter
public enum ApiErrorCode {

    INVALID_PARAMETER(400, "api.error.invalid_parameter", "파라미터가 잘못 되었습니다."),

    PAGE_NOT_FOUND(404, "api.error.page_not_found", "페이지를 찾을 수 없습니다."),

    METHOD_NOT_ALLOWED(405, "api.error.method_not_allowed", "지원하지 않는 메소드입니다."),

    CLIENT_ABORT(499, "api.error.client_abort", "클라이언트에서 연결을 종료했습니다."),

    //Device
    DEVICE_NOT_FOUND(404, "api.error.device_not_found", "디바이스를 찾을 수 없습니다."),

    DEVICE_ALREADY_EXISTS(400, "api.error.device_already_exists", "이미 존재하는 디바이스입니다."),

    // User
    USER_NOT_FOUND(404, "api.error.user_not_found", "존재하지 않는 유저입니다."),

    // Reservation
    ALREADY_RESERVED_DEVICE(400, "api.error.already_reserved_device", "이미 예약된 디바이스 입니다."),

    //Common
    NOT_AVAILABLE(400, "api.error.not_available", "불가능 한 동작입니다."),

    UNKNOWN(500, "api.error.unknown", "알 수 없는 에러입니다.");

    ApiErrorCode(int status, String code, String msg) {
        this.status = status;
        this.code = code;
        this.msg = msg;
    }

    private final int status;
    private final String code;
    private final String msg;
}
