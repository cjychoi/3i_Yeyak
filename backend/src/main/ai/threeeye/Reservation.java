package ai.threeeye;


import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Reservation {

    private final String device_id;
    private final String reservation_name;
    private final LocalDateTime start_date;
    private final LocalDateTime end_date;
    private final LocalDateTime start_time;
    private final LocalDateTime end_time;

}
