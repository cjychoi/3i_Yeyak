package ai.threeeye.yeyak.common.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ResultCode {

    USER_NOT_FOUND("USER_NOT_FOUND", "user not found"),
    USER_ALREADY_EXISTS("USER_ALREADY_EXISTS", "user already exists");

    private String code;
    private String message;

}
