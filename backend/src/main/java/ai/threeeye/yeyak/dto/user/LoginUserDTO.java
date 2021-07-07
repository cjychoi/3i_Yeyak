package ai.threeeye.yeyak.dto.user;

import lombok.*;

import javax.validation.constraints.NotEmpty;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class LoginUserDTO {

    @NotEmpty(message = "Username may not be empty")
    private String username;

}
