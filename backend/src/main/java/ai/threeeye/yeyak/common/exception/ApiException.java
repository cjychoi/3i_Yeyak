package ai.threeeye.yeyak.common.exception;

import ai.threeeye.yeyak.common.define.ApiErrorCode;
import lombok.Getter;

@Getter
public class ApiException extends Exception {

    private final int status;
    private final ApiErrorCode code;
    private final String msg;

    public ApiException(ApiErrorCode code) {
        super(code.getMsg());
        this.status = 400;
        this.code = code;
        this.msg = code.getMsg();
    }

    public ApiException(int status, ApiErrorCode code) {
        super(code.getMsg());
        this.status = status;
        this.code = code;
        this.msg = code.getMsg();
    }

    public ApiException(ApiErrorCode code, String msg) {
        super(msg);
        this.status = 4005;
        this.code = code;
        this.msg = msg;
    }

    public ApiException(int status, ApiErrorCode code, String msg) {
        super(msg);
        this.status = status;
        this.code = code;
        this.msg = msg;
    }

    public ApiErrorCode getOriginalCode() {
        return this.code;
    }

    public String getCode() {
        return this.code.getCode();
    }

}
