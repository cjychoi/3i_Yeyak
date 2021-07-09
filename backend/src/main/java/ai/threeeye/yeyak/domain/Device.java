package ai.threeeye.yeyak.domain;

import ai.threeeye.yeyak.common.define.device.OS;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Document("devices")
public class Device {

    @Id
    @Builder.Default
    private String _id = UUID.randomUUID().toString();

    @Indexed(unique = true)
    private String code;

    private String manufacturer;
    private String model;
    private String color;
    private OS os;
    private boolean availability;
    private String description;

    @CreatedDate
    @Builder.Default
    private LocalDateTime createdAt = LocalDateTime.now();
    @LastModifiedDate
    private LocalDateTime updatedAt;


}
