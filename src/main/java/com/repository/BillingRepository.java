package com.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.model.Bill;
import java.util.List;

public interface BillingRepository extends JpaRepository<Bill, Long> {
	List<Bill> findByPatientNameContaining(String patientName);
}
