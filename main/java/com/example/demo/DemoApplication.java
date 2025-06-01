// src/main/java/com/example/demo/DemoApplication.java
package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}

// src/main/java/com/example/demo/EmailController.java
package com.example.demo;

import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api")
public class EmailController {
    private List<String> emails = new ArrayList<>();

    @PostMapping("/email")
    public void addEmail(@RequestBody String email) {
        emails.add(email);
    }

    @GetMapping("/emails")
    public List<String> getEmails() {
        return emails;
    }
}