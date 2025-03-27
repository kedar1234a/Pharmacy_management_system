package com.service;

import com.model.Wholesaler;
import com.repository.WholesalerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class WholesalerService {

	@Autowired
	private WholesalerRepository wholesalerRepository;

	// Add a new wholesaler
    public Wholesaler addWholesaler(Wholesaler wholesaler) {
        return wholesalerRepository.save(wholesaler);
    }

    // Update an existing wholesaler
    public Wholesaler updateWholesaler(Wholesaler wholesaler) {
        Optional<Wholesaler> existingWholesaler = wholesalerRepository.findById(wholesaler.getId());
        if (existingWholesaler.isPresent()) {
            return wholesalerRepository.save(wholesaler);
        } else {
            throw new RuntimeException("Wholesaler not found with ID: " + wholesaler.getId());
        }
    }

    // Delete a wholesaler by ID
    public void deleteWholesaler(Long id) {
        Optional<Wholesaler> wholesaler = wholesalerRepository.findById(id);
        if (wholesaler.isPresent()) {
            wholesalerRepository.deleteById(id);
        } else {
            throw new RuntimeException("Wholesaler not found with ID: " + id);
        }
    }

    // Get all wholesalers
    public List<Wholesaler> getAllWholesalers() {
        return wholesalerRepository.findAll();
    }

    // Get a wholesaler by ID
    public Wholesaler getWholesalerById(Long id) {
        return wholesalerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Wholesaler not found with ID: " + id));
    }

    // Search wholesalers by name
    public List<Wholesaler> searchWholesalersByName(String name) {
        return wholesalerRepository.findByWholesalerNameContainingIgnoreCase(name);
    }
}