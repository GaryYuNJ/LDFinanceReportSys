package com.ld.springboot.shiro.sample;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * This guy is lazy, nothing left.
 *
 * @author John Zhang
 */
@SpringBootApplication
@RestController
public class SampleApplication {

	public static void main(String[] args) {
        SpringApplication.run(SampleApplication.class, args);
    }
	
    @RequestMapping(value = "/test")
    String hello() {
    	return "Hello World!";
    }
}
