package ai.threeeye.yeyak.dto.reservation;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotEmpty;
import java.time.LocalDateTime;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CreateReservationDTO {

    @NotEmpty(message = "UserId may not be empty")
    private String userId;
    @NotEmpty(message = "DeviceId may not be empty")
    private String deviceId;

    @NotEmpty(message = "StartedAt may not be empty")
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime startedAt;
    @NotEmpty(message = "EndedAt may not be empty")
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime endedAt;

}
