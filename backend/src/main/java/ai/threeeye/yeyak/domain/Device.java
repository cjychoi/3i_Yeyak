package ai.threeeye.yeyak.domain;

import lombok.*;

import java.time.LocalDateTime;

@Data
public class Device {

    private final String device_id;
    private final String manufacturer;
    private final String model;
    private final String color;
    private final String os;
    private final boolean availability;
    private final String description;

    private final LocalDateTime createdAt;
    private final LocalDateTime updatedAt;

}
