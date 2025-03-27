package com.controller;

import com.model.Wholesaler;
import com.service.WholesalerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class WholesalerController {

	@Autowired
	private WholesalerService wholesalerService;

	// Display the wholesaler form with the list of wholesalers
	@GetMapping("/wholesaler")
	public String showWholesalerForm(Model model) {
		model.addAttribute("wholesaler", new Wholesaler());
		model.addAttribute("wholesalers", wholesalerService.getAllWholesalers());
		return "wholesaler";
	}

	// Handle form submission (Add, Update, Delete)
	@PostMapping("/wholesaler")
	public String handleWholesalerForm(@ModelAttribute Wholesaler wholesaler, @RequestParam("action") String action,
			Model model) {
		try {
			switch (action) {
			case "Add":
				wholesalerService.addWholesaler(wholesaler);
				model.addAttribute("message", "Wholesaler added successfully!");
				break;
			case "Update":
				if (wholesaler.getId() != null) {
					wholesalerService.updateWholesaler(wholesaler);
					model.addAttribute("message", "Wholesaler updated successfully!");
				} else {
					model.addAttribute("error", "Please provide a valid ID for updating.");
				}
				break;
			case "Delete":
				if (wholesaler.getId() != null) {
					wholesalerService.deleteWholesaler(wholesaler.getId());
					model.addAttribute("message", "Wholesaler deleted successfully!");
				} else {
					model.addAttribute("error", "Please provide a valid ID for deletion.");
				}
				break;
			case "Show All":
				break;
			case "Search":
				String searchName = wholesaler.getWholesalerName();
				List<Wholesaler> searchResults = wholesalerService.searchWholesalersByName(searchName);
				model.addAttribute("wholesalers", searchResults);
				return "wholesaler";
			default:
				model.addAttribute("error", "Invalid action!");
				break;
			}
		} catch (Exception e) {
			model.addAttribute("error", e.getMessage());
		}
		model.addAttribute("wholesaler", new Wholesaler());
		model.addAttribute("wholesalers", wholesalerService.getAllWholesalers());
		return "wholesaler";
	}

	// Handle the "Update" button click from the table
	@PostMapping("/wholesaler/edit")
	public String editWholesaler(@RequestParam("id") Long id, Model model) {
		Wholesaler wholesaler = wholesalerService.getWholesalerById(id);
		model.addAttribute("wholesaler", wholesaler); // Populate the form with the wholesaler's data
		model.addAttribute("wholesalers", wholesalerService.getAllWholesalers());
		return "wholesaler";
	}
}