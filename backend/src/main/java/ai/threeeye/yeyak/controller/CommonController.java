package ai.threeeye.yeyak.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/status")
public class CommonController {

    @GetMapping
    public String status() {
        return "OK";
    }

}
