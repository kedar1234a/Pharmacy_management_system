package com.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model.Purchase;
import com.service.PurchaseService;

@Controller
public class PurchaseController {

    @Autowired
    private PurchaseService purchaseService;

    @PostMapping("/savePurchase")
    public String saveOrUpdatePurchase(@RequestParam(required = false) Long id, // Allow null for new entries
                                       @RequestParam String medicineName, @RequestParam String purchaseDate, @RequestParam int quantity,
                                       @RequestParam double price, @RequestParam String invoice, @RequestParam String manufactureDate,
                                       @RequestParam String expiryDate, @RequestParam String batchNo, @RequestParam String wholesalerName) {

        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedPurchaseDate = formatter.parse(purchaseDate);
            Date parsedManufactureDate = formatter.parse(manufactureDate);
            Date parsedExpiryDate = formatter.parse(expiryDate);

            Purchase purchase;

            // **Check if ID exists - Update the record, else create a new one**
            if (id != null) {
                purchase = purchaseService.getPurchaseById(id);
                if (purchase == null) {
                    return "redirect:/purchase"; // If not found, redirect
                }
            } else {
                purchase = new Purchase(); // New object for fresh entries
            }

            purchase.setMedicineName(medicineName);
            purchase.setPurchaseDate(parsedPurchaseDate);
            purchase.setQuantity(quantity);
            purchase.setPrice(price);
            purchase.setInvoice(invoice);
            purchase.setManufactureDate(parsedManufactureDate);
            purchase.setExpiryDate(parsedExpiryDate);
            purchase.setBatchNo(batchNo);
            purchase.setWholesalerName(wholesalerName);

            purchaseService.savePurchase(purchase); // Save or update
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/purchase"; // Redirect after saving/updating
    }

    @GetMapping("/purchase")
    public String showPurchasePage(Model model) {
        model.addAttribute("purchase", new Purchase()); // Empty form for new entry
        return "purchase";
    }
}
