package ai.threeeye.yeyak.domain;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Document("reservations")
public class Reservation {

    @Id
    @Builder.Default
    private String _id = UUID.randomUUID().toString();

    @DBRef
    private User user;
    @DBRef
    private Device device;

    private LocalDateTime startedAt;
    private LocalDateTime endedAt;

    @CreatedDate
    private LocalDateTime createdAt;
    @LastModifiedDate
    private LocalDateTime updatedAt;

}
