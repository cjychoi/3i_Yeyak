package ai.threeeye.yeyak.common.filter;

import ai.threeeye.yeyak.common.lib.ResponseWrapper;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

@Slf4j
@Order(2)
@Component
public class LoggerFilter implements Filter {

    private ObjectMapper om = new ObjectMapper();

    public LoggerFilter() {
        om.enable(SerializationFeature.INDENT_OUTPUT);
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
//        if ("".equals(((HttpServletRequest) req).getRequestURI())) {
//            chain.doFilter(req, res);
//            return;
//        }
        HttpServletResponse resp = (HttpServletResponse) res;
        ResponseWrapper response = new ResponseWrapper(resp);
        response.setHeader("Content-Security-Policy", "script-src 'self'");
        response.setHeader("X-Content-Type-Options", "nosniff");
        response.setHeader("X-XSS-Protection", "1;mode=block");
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        String URI = ((HttpServletRequest) req).getRequestURI();
        String METHOD = "[" + ((HttpServletRequest) req).getMethod() + "]";
        String IP = ((HttpServletRequest) req).getHeader("x-real-ip");
        if (!StringUtils.hasText(IP)) {
            IP = req.getRemoteAddr();
        }
        String USER_AGENT = ((HttpServletRequest) req).getHeader("User-Agent");
        long time = System.currentTimeMillis();

        try {
            log.info("USER-AGENT: {}", USER_AGENT);
            log.info("{} REQUEST {} {} --> ", METHOD, URI, IP);
            log.info("CONTENT-TYPE: {}", req.getContentType());
            //TODO: Content-Type에 따라서 Request 로그 바꾸기/ application/json일때 로그 안나옴
            log.info("\nHTTP REQUEST PARAMETER\n{} ", om.writeValueAsString(req.getParameterMap()));

            chain.doFilter(req, response);
        } finally {
            response.flushBuffer();
            byte[] copy = response.getCopy();

            String responseBody = new String(copy, StandardCharsets.UTF_8);
            JSONObject body;
            try {
                if (StringUtils.hasText(responseBody)) {
                    body = new JSONObject(responseBody);
                    log.info("\nSTATUS CODE: {}\nHTTP RESPONSE:\n{}", response.getStatus(),
                            body.toString(2));
                }
            } catch (Exception e) {
                log.error("RESPONSE PARSE ERROR, ERR_MSG: {}, RAW: {}", e, responseBody);
            }
            time = System.currentTimeMillis() - time;
            log.info("{} REQUEST {} {} <-- {}ms", METHOD, URI, IP, time);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) {
        log.debug("################### log FILTER INIT ###################");
    }

    @Override
    public void destroy() {
        log.debug("################### log FILTER END. ###################");
    }

}
