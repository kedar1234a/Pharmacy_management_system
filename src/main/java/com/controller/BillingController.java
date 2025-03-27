package com.controller;

import com.model.Bill;
import com.model.Purchase;
import com.service.BillingService;
import com.service.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/billing")
public class BillingController {

    @Autowired
    private BillingService billService;

    @Autowired
    private PurchaseService purchaseService;

    // Validation patterns
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");
    private static final Pattern NAME_PATTERN = Pattern.compile("^[a-zA-Z\\s]+$");

    @GetMapping("/form")
    public String showBillingPage(Model model) {
        List<Purchase> medicines = purchaseService.getAllPurchases();
        model.addAttribute("medicines", medicines);
        
        List<Bill> bills = billService.getAllBills();
        model.addAttribute("bills", bills);
        
        return "billing";
    }

    @PostMapping("/save")
    @ResponseBody
    public ResponseEntity<?> saveBill(@RequestBody Bill bill) {
        // Validation using Map to store errors
        Map<String, String> validationErrors = validateBill(bill);
        
        if (!validationErrors.isEmpty()) {
            return ResponseEntity.badRequest().body(validationErrors);
        }

        Bill savedBill = billService.saveBill(bill);
        purchaseService.deductStock(bill.getMedicineName(), bill.getQuantity());
        generateBillFile(savedBill);
        return ResponseEntity.ok(savedBill);
    }

    @GetMapping("/getMedicinePrice")
    @ResponseBody
    public double getMedicinePrice(@RequestParam String medicineName) {
        return purchaseService.getMedicinePrice(medicineName);
    }

    private Map<String, String> validateBill(Bill bill) {
        Map<String, String> errors = new HashMap<>();
        
        // Validate patient name
        if (bill.getPatientName() == null || bill.getPatientName().trim().isEmpty()) {
            errors.put("patientName", "Name cannot be empty");
        } else if (!NAME_PATTERN.matcher(bill.getPatientName()).matches()) {
            errors.put("patientName", "Name should contain only letters and spaces");
        } else if (bill.getPatientName().trim().split("\\s+").length < 2) {
            errors.put("patientName", "Please provide full name (at least first and last name)");
        }

        // Validate patient contact
        if (bill.getPatientContact() == null || bill.getPatientContact().isEmpty()) {
            errors.put("patientContact", "Contact number cannot be empty");
        } else if (!PHONE_PATTERN.matcher(bill.getPatientContact()).matches()) {
            errors.put("patientContact", "Contact number must be exactly 10 digits");
        }

        return errors;
    }

    private void generateBillFile(Bill bill) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String fileName = "bill_" + bill.getId() + ".txt";
        
        try (FileWriter writer = new FileWriter(fileName)) {
            writer.write(generateBillContent(bill));
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @PostMapping("/generateBill")
    @ResponseBody
    public String generateBill(@RequestParam Long billId) {
        Bill bill = billService.getBillById(billId);
        if (bill != null) {
            generateBillFile(bill);
            return "Bill generated successfully: bill_" + bill.getId() + ".txt";
        } else {
            return "Bill not found.";
        }
    }

    @GetMapping("/downloadBill")
    public ResponseEntity<Resource> downloadBill(@RequestParam Long billId) {
        Bill bill = billService.getBillById(billId);
        if (bill == null) {
            return ResponseEntity.notFound().build();
        }

        String billContent = generateBillContent(bill);
        String fileName = "bill_" + bill.getId() + ".txt";

        try {
            Path tempFile = Files.createTempFile(fileName, ".txt");
            Files.write(tempFile, billContent.getBytes());
            Resource resource = new UrlResource(tempFile.toUri());

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + fileName)
                    .contentType(MediaType.TEXT_PLAIN)
                    .body(resource);
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).build();
        }
    }

    private String generateBillContent(Bill bill) {
        String header = String.format("| %-10s | %-20s | %-15s | %-20s | %-10s | %-8s | %-12s | %-12s |\n",
            "Bill ID", "Patient Name", "Patient Contact", "Medicine Name", "Date", "Quantity", "Cost/Unit", "Total Cost");
        
        String separator = "|------------|----------------------|-----------------|----------------------|------------|----------|-------------|-------------|\n";
        
        String content = String.format("| %-10s | %-20s | %-15s | %-20s | %-10s | %-8d | %-12.2f | %-12.2f |\n",
            bill.getId(),
            bill.getPatientName(),
            bill.getPatientContact(),
            bill.getMedicineName(),
            new SimpleDateFormat("yyyy-MM-dd").format(bill.getDate()),
            bill.getQuantity(),
            bill.getCostPerUnit(),
            bill.getTotalCost());

        return header + separator + content;
    }
    
    @GetMapping("/sale_history")
    public String viewSaleHistory(Model model) {
        List<Bill> bills = billService.getAllBills();
        model.addAttribute("bills", bills);
        return "salehistory";
    }
}