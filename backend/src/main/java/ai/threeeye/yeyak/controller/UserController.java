package ai.threeeye.yeyak.controller;

import ai.threeeye.yeyak.common.define.ApiErrorCode;
import ai.threeeye.yeyak.common.exception.ApiException;
import ai.threeeye.yeyak.dto.user.LoginUserDTO;
import ai.threeeye.yeyak.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody LoginUserDTO payload, HttpServletResponse res) {
        Map<String, Object> returnMap = new HashMap<>();

        try {
            returnMap.put("result", 1);
            returnMap.put("data", userService.login(payload));
        } catch (ApiException e) {
            res.setStatus(e.getStatus());
            returnMap.put("result", 0);
            returnMap.put("resultCode", e.getCode());
            returnMap.put("resultMsg", e.getMsg());
        } catch (Exception e) {
            log.error("", e);
            res.setStatus(ApiErrorCode.UNKNOWN.getStatus());
            returnMap.put("result", 0);
            returnMap.put("resultCode", ApiErrorCode.UNKNOWN.getCode());
            returnMap.put("resultMsg", ApiErrorCode.UNKNOWN.getMsg());
        }

        return returnMap;
    }

}
