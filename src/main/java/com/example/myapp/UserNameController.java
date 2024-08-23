package com.example.myapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserNameController {

    @Autowired
    private UserRepository repository;

    @GetMapping
    public List<User> getAllEntities() {
        return repository.findAll();
    }
}
