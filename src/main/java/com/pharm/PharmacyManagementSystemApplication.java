package com.pharm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages = "com")
@EnableJpaRepositories("com.repository")
@EntityScan("com.model")

public class PharmacyManagementSystemApplication {

	public static void main(String[] args) {
		SpringApplication.run(PharmacyManagementSystemApplication.class, args);
	}

}
