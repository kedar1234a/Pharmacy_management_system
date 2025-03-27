package com.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "purchases")
public class Purchase {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String medicineName;
	private Date purchaseDate;
	private int quantity;
	private double price;
	private String invoice;
	private Date manufactureDate;
	private Date expiryDate;
	private String batchNo;
	private String wholesalerName;

	public Purchase() {
		
	}
	public Purchase(String medicineName, Date purchaseDate, int quantity, double price, String invoice,
			Date manufactureDate, Date expiryDate, String batchNo, String wholesalerName) {
		this.medicineName = medicineName;
		this.purchaseDate = purchaseDate;
		this.quantity = quantity;
		this.price = price;
		this.invoice = invoice;
		this.manufactureDate = manufactureDate;
		this.expiryDate = expiryDate;
		this.batchNo = batchNo;
		this.wholesalerName = wholesalerName;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getMedicineName() {
		return medicineName;
	}

	public void setMedicineName(String medicineName) {
		this.medicineName = medicineName;
	}

	public Date getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getInvoice() {
		return invoice;
	}

	public void setInvoice(String invoice) {
		this.invoice = invoice;
	}

	public Date getManufactureDate() {
		return manufactureDate;
	}

	public void setManufactureDate(Date manufactureDate) {
		this.manufactureDate = manufactureDate;
	}

	public Date getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	public String getWholesalerName() {
		return wholesalerName;
	}

	public void setWholesalerName(String wholesalerName) {
		this.wholesalerName = wholesalerName;
	}
}
