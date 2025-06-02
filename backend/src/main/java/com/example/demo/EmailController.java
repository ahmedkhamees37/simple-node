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