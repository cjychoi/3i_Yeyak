package ai.threeeye.yeyak.common.response;

import lombok.Data;

import javax.validation.ConstraintViolation;
import java.util.Set;
import java.util.stream.Collectors;

@Data
public class Result {

    private int statusCode;
    private String code;
    private String message;
    private Object data;

    public Result(int statusCode, ResultCode code) {
        this.statusCode = statusCode;
        this.code = code.getCode();
        this.message = code.getMessage();
        this.data = null;
    }

    public Result(int statusCode, Set<? extends ConstraintViolation<?>> e) {
        this.statusCode = statusCode;
        this.code = null;
        this.message = e.stream()
                .map(ConstraintViolation::getMessage)
                .collect(Collectors.joining(", "));
    }

    public Result(int statusCode, Object data) {
        this.statusCode = statusCode;
        this.data = data;
    }

}
