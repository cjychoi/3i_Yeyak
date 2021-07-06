package ai.threeeye.yeyak.common.lib;

import ai.threeeye.yeyak.common.define.CodeEnum;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;

import java.io.IOException;

public class EnumSerializer extends StdSerializer<CodeEnum> {

    private static final long serialVersionUID = 6665208011248144865L;

    protected EnumSerializer(Class<CodeEnum> t) {
        super(t);
    }

    public EnumSerializer() {
        this(null);
    }

    @Override
    public void serialize(CodeEnum value, JsonGenerator gen, SerializerProvider provider) throws IOException {
        gen.writeString(value.toString());
    }

}
