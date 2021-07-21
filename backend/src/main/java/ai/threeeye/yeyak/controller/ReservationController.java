package ai.threeeye.yeyak.controller;

import ai.threeeye.yeyak.common.define.ApiErrorCode;
import ai.threeeye.yeyak.common.exception.ApiException;
import ai.threeeye.yeyak.dto.reservation.CreateReservationDTO;
import ai.threeeye.yeyak.service.ReservationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/reservations")
@RequiredArgsConstructor
public class ReservationController {

    private final ReservationService reservationService;

    @GetMapping
    public Map<String, Object> list(
            @RequestParam(name = "deviceId", required = false) String deviceId,
            @RequestParam(name = "userId", required = false) String userId,
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @RequestParam(name = "startedAt", required = false) LocalDateTime startedAt,
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) @RequestParam(name = "endedAt", required = false) LocalDateTime endedAt,
            HttpServletResponse res) {
        Map<String, Object> returnMap = new HashMap<>();

        try {
            returnMap.put("result", 1);
            returnMap.put("data", reservationService.list(deviceId, userId, startedAt, endedAt));
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

    @PostMapping
    public Map<String, Object> create(@RequestBody CreateReservationDTO payload, HttpServletResponse res) {
        Map<String, Object> returnMap = new HashMap<>();

        try {
            returnMap.put("result", 1);
            returnMap.put("data", reservationService.create(payload));
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
