package ai.threeeye.yeyak.common.lib;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import java.io.IOException;
import java.io.PrintWriter;

public class ResponseWrapper extends HttpServletResponseWrapper {

    private ServletOutputStream outputStream;
    private PrintWriter writer;
    private OutputStreamWrapper copy;

    public ResponseWrapper(HttpServletResponse response) {
        super(response);
    }

    @Override
    public ServletOutputStream getOutputStream() throws IOException {
        if (writer != null) {
            throw new IllegalStateException(
                    "getWriter() has already been called on this response.");
        }

        if (outputStream == null) {
            this.outputStream = getResponse().getOutputStream();
            copy = new OutputStreamWrapper(this.outputStream);
        }

        return copy;
    }

    @Override
    public void flushBuffer() throws IOException {
        if (writer != null) {
            writer.flush();
        } else if (outputStream != null) {
            copy.flush();
        }
    }

    public byte[] getCopy() {
        if (copy != null) {
            return copy.getCopy();
        } else {
            return new byte[0];
        }
    }


}
