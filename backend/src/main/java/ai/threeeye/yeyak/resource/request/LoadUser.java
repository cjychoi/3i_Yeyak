package ai.threeeye.yeyak.resource.request;

import lombok.*;

import javax.validation.constraints.NotEmpty;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class LoadUser {

    @NotEmpty
    private String username;

}
