package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model.Purchase;
import com.service.PurchaseService;

@Controller
public class StockController {

    @Autowired
    private PurchaseService purchaseService;

    // Display Stock Page
    @GetMapping("/stock")
    public String showStockPage(@RequestParam(value = "query", required = false) String query, Model model) {
        List<Purchase> purchases = (query != null && !query.isEmpty()) 
                ? purchaseService.searchPurchases(query)
                : purchaseService.getAllPurchases();
        model.addAttribute("purchases", purchases);
        return "stock"; // Loads stock.jsp
    }

    // Search Stock
    @GetMapping("/searchStock")
    public String searchStock(@RequestParam("query") String query, Model model) {
        List<Purchase> searchResults = purchaseService.searchPurchases(query);
        model.addAttribute("purchases", searchResults);
        return "stock"; // Loads stock.jsp with search results
    }

    // Add Stock (Redirect to Purchase Form)
    @GetMapping("/addStock")
    public String addStock() {
        return "redirect:/purchase"; // Redirects to purchase.jsp to add new stock
    }

    // Delete Stock Item
    @GetMapping("/deleteStock")
    public String deleteStock(@RequestParam("id") Long id) {
        purchaseService.deletePurchase(id);
        return "redirect:/stock"; // Redirect back to stock.jsp after deletion
    }

    // Redirect Update to Purchase Page
    @GetMapping("/updateStock")
    public String showUpdateForm(@RequestParam("id") Long id, Model model) {
        Purchase purchase = purchaseService.getPurchaseById(id);
        if (purchase == null) {
            return "redirect:/stock"; // If not found, go back to stock list
        }
        model.addAttribute("purchase", purchase);
        return "purchase"; // Redirects to purchase.jsp with pre-filled values
    }
}
