package com.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "bills")
public class Bill {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String patientName;
    private String patientContact;
    private String medicineName;
    private Date date;
    private int quantity;
    private double costPerUnit;
    private double totalCost;

    // Constructors
    public Bill() {}

    public Bill(String patientName, String patientContact, String medicineName, Date date, int quantity, double costPerUnit, double totalCost) {
        this.patientName = patientName;
        this.patientContact = patientContact;
        this.medicineName = medicineName;
        this.date = date;
        this.quantity = quantity;
        this.costPerUnit = costPerUnit;
        this.totalCost = totalCost;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getPatientContact() { return patientContact; }
    public void setPatientContact(String patientContact) { this.patientContact = patientContact; }

    public String getMedicineName() { return medicineName; }
    public void setMedicineName(String medicineName) { this.medicineName = medicineName; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getCostPerUnit() { return costPerUnit; }
    public void setCostPerUnit(double costPerUnit) { this.costPerUnit = costPerUnit; }

    public double getTotalCost() { return totalCost; }
    public void setTotalCost(double totalCost) { this.totalCost = totalCost; }
}
