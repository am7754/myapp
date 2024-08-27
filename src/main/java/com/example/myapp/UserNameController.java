package com.example.myapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/users")
public class UserNameController {

    private final JdbcTemplate jdbcTemplate;

    public UserNameController(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }

    @GetMapping
    public List<String> getAllEntities() {
        return this.jdbcTemplate.queryForList("SELECT * FROM users").stream()
                .map(m -> m.values().toString())
                .collect(Collectors.toList());
    }
}
