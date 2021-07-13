package ai.threeeye.yeyak.common.define.device;

import ai.threeeye.yeyak.common.define.CodeEnum;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum OS implements CodeEnum {

    @JsonProperty("Android")
    ANDROID("Android"),

    @JsonProperty("iOS")
    IPHONE("iOS");

    private final String name;

    @Override
    public String toString() {
        return this.name;
    }

}