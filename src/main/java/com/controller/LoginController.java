package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.model.User;
import com.model.Admin;
import com.service.UserService;
import com.service.AdminService;

import jakarta.servlet.http.HttpSession;

import java.util.List;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @Autowired
    private AdminService adminService;

    // Show Login Page
    @GetMapping("/")
    public String showLoginPage() {
        return "login";
    }

    // Show User Registration Page
    @GetMapping("/register")
    public String showRegisterPage() {
        return "user_register";
    }

    // Process User Registration
    @PostMapping("/register")
    public String registerUser(@RequestParam("username") String username, @RequestParam("password") String password,
            Model model) {
        // Check if username already exists
        if (userService.findByUsername(username) != null) {
            model.addAttribute("error", "Username already exists! Please choose a different username.");
            return "user_register";
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        userService.registerUser(user);
        model.addAttribute("message", "User registered successfully! Please login.");
        return "login";
    }

    // Process Login for Admin and Users
    @PostMapping("/login")
    public String processLogin(@RequestParam("username") String username, @RequestParam("password") String password,
            Model model) {
        if (adminService.isAdmin(username, password)) {
            return "admin_dashboard";
        }
        User user = userService.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return "user_dashboard";
        }
        model.addAttribute("error", "Invalid username or password");
        return "login";
    }

    // View All Users (Admin Feature)
    @GetMapping("/viewUsers")
    public String viewUsers(Model model, @RequestParam(value = "username", required = false) String username) {
        List<User> users;
        if (username != null && !username.trim().isEmpty()) {
            users = userService.findUsersByUsername(username);
        } else {
            users = userService.getAllUsers();
        }
        model.addAttribute("users", users);
        return "view_users";
    }

    // Delete User (Admin Feature)
    @PostMapping("/deleteUser")
    public String deleteUser(@RequestParam("id") Long id, Model model) {
        userService.deleteUser(id);
        model.addAttribute("message", "User deleted successfully!");
        return "redirect:/viewUsers";
    }

    // Show Admin Registration Page with Admin List
    @GetMapping("/adminRegister")
    public String showAdminRegisterPage(Model model) {
        model.addAttribute("admin", new Admin());
        model.addAttribute("admins", adminService.getAllAdmins()); // Always load admins
        return "admin_register";
    }

    // Process Admin Registration (Save)
    @PostMapping("/adminRegister")
    public String registerAdmin(@ModelAttribute("admin") Admin admin, Model model) {
        // Check if admin username already exists
        if (adminService.findByUsername(admin.getUsername()) != null) {
            model.addAttribute("error", "Admin username already exists! Please choose a different username.");
            model.addAttribute("admin", admin); // Preserve form data
            model.addAttribute("admins", adminService.getAllAdmins());
            return "admin_register";
        }
        try {
            adminService.registerAdmin(admin);
            model.addAttribute("message", "Admin registered successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "Error registering admin: " + e.getMessage());
        }
        // Reload the form and updated admin list
        model.addAttribute("admin", new Admin()); // Reset form
        model.addAttribute("admins", adminService.getAllAdmins());
        return "admin_register";
    }

    // Delete Admin (Admin Feature)
    @PostMapping("/deleteAdmin")
    public String deleteAdmin(@RequestParam("id") Long id, Model model) {
        if (adminService.getAllAdmins().size() <= 1) {
            model.addAttribute("error", "Cannot delete the last admin!");
        } else {
            adminService.deleteAdmin(id);
            model.addAttribute("message", "Admin deleted successfully!");
        }
        // Reload the form and updated admin list
        model.addAttribute("admin", new Admin());
        model.addAttribute("admins", adminService.getAllAdmins());
        return "admin_register";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, Model model) {
        session.invalidate(); // Invalidate the session to log out the user
        model.addAttribute("message", "You have been logged out successfully.");
        return "login"; // Redirect to login page
    }
}