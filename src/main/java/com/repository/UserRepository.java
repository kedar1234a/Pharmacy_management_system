package com.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.model.User;


@Repository
public interface UserRepository extends JpaRepository<User, Long> {
	User findByUsername(String username);

	List<User> findByUsernameContainingIgnoreCase(String username);
}
