package ai.threeeye.yeyak.common.config;

import ai.threeeye.yeyak.common.define.ApiErrorCode;
import ai.threeeye.yeyak.common.exception.ApiException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.HttpStatus;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingRequestHeaderException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.server.MethodNotAllowedException;
import org.springframework.web.servlet.NoHandlerFoundException;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestControllerAdvice
public class DefaultControllerAdvice {

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
        binder.registerCustomEditor(String.class, stringTrimmerEditor);
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler({MissingServletRequestParameterException.class,
            MissingRequestHeaderException.class})
    public Map<String, Object> missingParam() {
        log.error("Missing Param");
        Map<String, Object> returnMap = new HashMap<>();

        returnMap.put("result", 0);
        returnMap.put("resultCode", ApiErrorCode.INVALID_PARAMETER.getCode());
        returnMap.put("resultMsg", ApiErrorCode.INVALID_PARAMETER.getMsg());

        return returnMap;
    }

    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ExceptionHandler({NoHandlerFoundException.class})
    public Map<String, Object> notFound() {
        log.error("Page Not Found");
        Map<String, Object> returnMap = new HashMap<>();

        returnMap.put("result", 0);
        returnMap.put("resultCode", ApiErrorCode.PAGE_NOT_FOUND.getCode());
        returnMap.put("resultMsg", ApiErrorCode.PAGE_NOT_FOUND.getMsg());

        return returnMap;
    }

    @ResponseStatus(HttpStatus.METHOD_NOT_ALLOWED)
    @ExceptionHandler({MethodNotAllowedException.class,
            HttpRequestMethodNotSupportedException.class})
    public Map<String, Object> methodNotAllowed() {
        log.error("Method Not Allowed");
        Map<String, Object> returnMap = new HashMap<>();

        returnMap.put("result", 0);
        returnMap.put("resultCode", ApiErrorCode.METHOD_NOT_ALLOWED.getCode());
        returnMap.put("resultMsg", ApiErrorCode.METHOD_NOT_ALLOWED.getMsg());

        return returnMap;
    }

    @ExceptionHandler({IOException.class})
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public Map<String, Object> ioException(IOException e) {
        log.error("Client abort");
        Map<String, Object> returnMap = new HashMap<>();

        e.printStackTrace();

        returnMap.put("result", 0);
        returnMap.put("resultCode", ApiErrorCode.CLIENT_ABORT.getCode());
        returnMap.put("resultMsg", ApiErrorCode.CLIENT_ABORT.getMsg());

        return returnMap;
    }

    @ExceptionHandler({ApiException.class})
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, Object> apiException(ApiException e) {
        Map<String, Object> returnMap = new HashMap<>();

        returnMap.put("result", 0);
        returnMap.put("resultCode", e.getCode());
        returnMap.put("resultMsg", e.getMsg());

        return returnMap;
    }

    @ExceptionHandler({MethodArgumentTypeMismatchException.class})
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, Object> methodArgumentTypeMismatchException(
            MethodArgumentTypeMismatchException e) {
        log.error("", e);
        Map<String, Object> returnMap = new HashMap<>();

        returnMap.put("result", 0);
        returnMap.put("resultCode", ApiErrorCode.INVALID_PARAMETER.getCode());
        returnMap.put("resultMsg", ApiErrorCode.INVALID_PARAMETER.getMsg());

        return returnMap;
    }

    @ExceptionHandler({MethodArgumentNotValidException.class})
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, Object> methodArgumentsNotValidException(
            MethodArgumentNotValidException e
    ) {
        log.error("", e);
        Map<String, Object> returnMap = new HashMap<>();

        {
            returnMap.put("result", 0);
            returnMap.put("resultCode", ApiErrorCode.INVALID_PARAMETER.getCode());
            returnMap.put("resultMsg", e.getMessage());
        }

        return returnMap;
    }

}
