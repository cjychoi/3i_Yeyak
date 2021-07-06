package ai.threeeye.yeyak.domain;


import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Reservation {

    private final String id;
    private final String userId;
    private final String deviceId;
    private final LocalDateTime startedAt;
    private final LocalDateTime endedAt;

}
