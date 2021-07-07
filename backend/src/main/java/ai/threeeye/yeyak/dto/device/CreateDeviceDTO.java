package ai.threeeye.yeyak.dto.device;

import ai.threeeye.yeyak.common.define.device.OS;
import lombok.*;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CreateDeviceDTO {

    @NotEmpty(message = "Manufacturer may not be empty")
    private String manufacturer;
    @NotEmpty(message = "Code may not be empty")
    private String code;
    @NotEmpty(message = "Model may not be empty")
    private String model;
    @NotEmpty(message = "Color may not be empty")
    private String color;
    @NotNull(message = "OS may not be null")
    private OS os;
    @NotNull(message = "Availability may not be null")
    private Boolean availability;

    private String description;

}
