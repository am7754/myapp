package com.example.myapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MyappApplication {

	public static void main(String[] args) {
		System.out.println("Starting the application");
		System.out.println("-----------------------------------");
		SpringApplication.run(MyappApplication.class, args);
		System.out.println("------------------Started -----------------------------------");

	}

}
