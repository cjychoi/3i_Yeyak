package ai.threeeye.yeyak.resource.request;

import lombok.*;

import javax.validation.constraints.NotEmpty;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CreateUser {

    @NotEmpty(message="Username may not be empty")
    private String username;

}
