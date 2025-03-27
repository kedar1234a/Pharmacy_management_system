package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.model.Purchase;
import com.repository.PurchaseRepository;

import java.util.List;

@Service
public class PurchaseService {

	@Autowired
	private PurchaseRepository purchaseRepository;

	public List<Purchase> getAllPurchases() {
		return purchaseRepository.findAll();
	}

	public Purchase getPurchaseByMedicineName(String medicineName) {
		return purchaseRepository.findByMedicineName(medicineName);
	}

	public Purchase savePurchase(Purchase purchase) {
		return purchaseRepository.save(purchase);
	}

	public Purchase getPurchaseById(Long id) {
		return purchaseRepository.findById(id).orElse(null);
	}

	public void deletePurchase(Long id) {
		purchaseRepository.deleteById(id);
	}

	public void updatePurchase(Purchase purchase) {
		purchaseRepository.save(purchase);
	}

	public List<Purchase> searchPurchases(String query) {
		return purchaseRepository.findByMedicineNameContainingIgnoreCase(query);
	}

	public List<Purchase> getAllMedicines() {
		return purchaseRepository.findAll();
	}
	
	public double getMedicinePrice(String medicineName) {
        Purchase purchase = purchaseRepository.findByMedicineName(medicineName);
        return (purchase != null) ? purchase.getPrice() : 0.0;
    }

	public void deductStock(String medicineName, int quantity) {
        Purchase purchase = purchaseRepository.findByMedicineName(medicineName);
        if (purchase != null && purchase.getQuantity() >= quantity) {
            purchase.setQuantity(purchase.getQuantity() - quantity);
            purchaseRepository.save(purchase);
        } else {
            throw new RuntimeException("Insufficient stock for " + medicineName);
        }
    }
	
	
	
}
