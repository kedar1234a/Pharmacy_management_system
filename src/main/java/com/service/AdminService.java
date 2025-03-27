package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.repository.AdminRepository;
import com.model.Admin;
import com.model.User;

@Service
public class AdminService {

	@Autowired
	private AdminRepository adminRepository;

	public boolean isAdmin(String username, String password) {
		Admin admin = adminRepository.findByUsername(username);
		return admin != null && admin.getPassword().equals(password);
	}

	public void registerAdmin(Admin admin) {
		adminRepository.save(admin);

	}

	public List<Admin> getAllAdmins() {
        return adminRepository.findAll();
    }

	public void deleteAdmin(Long id) {
        adminRepository.deleteById(id);
    }
	
	public List<Admin> findAdminsByUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return getAllAdmins();
        }
        return adminRepository.findByUsernameContainingIgnoreCase(username);
    }
	
	public Admin findByUsername(String username) {
        return adminRepository.findByUsername(username); // Returns null if not found
    }

}
