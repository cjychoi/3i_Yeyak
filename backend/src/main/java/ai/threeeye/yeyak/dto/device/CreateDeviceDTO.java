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

    @NotEmpty(message = "Please type manufacturer")
    private String manufacturer;
    @NotEmpty(message = "Please type code")
    private String code;
    @NotEmpty(message = "Please type model")
    private String model;
    @NotEmpty(message = "Please type color")
    private String color;
    @NotNull(message = "Please type os")
    private OS os;
    @NotNull(message = "Please type availability")
    private Boolean availability;

    private String description;

}
