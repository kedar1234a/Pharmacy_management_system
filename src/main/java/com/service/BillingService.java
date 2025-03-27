package com.service;

import com.model.Bill;
import com.repository.BillingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BillingService {

	@Autowired
	private BillingRepository billRepository;

	public Bill saveBill(Bill bill) {
		return billRepository.save(bill);
	}

	public List<Bill> getAllBills() {
		return billRepository.findAll();
	}
	
	public Bill getBillById(Long billId) {
	    return billRepository.findById(billId).orElse(null);
	}
}
