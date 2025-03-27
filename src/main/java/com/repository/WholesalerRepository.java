package com.repository;

import com.model.Wholesaler;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WholesalerRepository extends JpaRepository<Wholesaler, Long> {
	// You can add custom query methods here if needed
	List<Wholesaler> findByWholesalerNameContainingIgnoreCase(String wholesalerName);
}