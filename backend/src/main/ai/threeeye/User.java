package ai.threeeye;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class User {

    private final String id;
    private final String user_name;
    private final String team; // team need??

    private final LocalDateTime createdAt;
    private final LocalDateTime updatedAt;

}
