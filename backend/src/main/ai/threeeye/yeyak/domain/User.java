package ai.threeeye.yeyak.domain;

import lombok.*;
import org.bson.Document;

import java.time.LocalDateTime;
import java.util.Objects;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class User extends Document {

    private String _id;
    private String username;
    private String team; // team need??

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof User)) {
            return false;
        }

        User other = (User) obj;
        return Objects.equals(other.username, this.username);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.username);
    }

}
