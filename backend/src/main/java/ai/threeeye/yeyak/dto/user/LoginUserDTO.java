package ai.threeeye.yeyak.dto.user;

import lombok.*;
import org.springframework.util.StringUtils;

import javax.validation.constraints.NotEmpty;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class LoginUserDTO {

    @NotEmpty(message = "Username may not be empty")
    private String username;

    public void setUsername(String username) {
        if (StringUtils.hasText(username)) {
            this.username = username.trim().toLowerCase();
        }

        this.username = username;
    }

}
