package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.model.User;
import com.repository.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	public void registerUser(User user) {
		userRepository.save(user);
	}

	public User findByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	// In UserServiceImpl.java
	public List<User> getAllUsers() {
		return userRepository.findAll();
	}

	public List<User> findUsersByUsername(String username) {
		return userRepository.findByUsernameContainingIgnoreCase(username);
	}

	public void deleteUser(Long id) {
		userRepository.deleteById(id);
	}
}
