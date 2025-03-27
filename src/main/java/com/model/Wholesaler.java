package com.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Wholesaler {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String wholesalerName;
    private String wholesalerContact;
    private String address;
    private String dealsWith;
    private String idType;
    private String idProof;

    // Default constructor
    public Wholesaler() {}

    // Parameterized constructor
    public Wholesaler(String wholesalerName, String wholesalerContact, String address, 
                     String dealsWith, String idType, String idProof) {
        this.wholesalerName = wholesalerName;
        this.wholesalerContact = wholesalerContact;
        this.address = address;
        this.dealsWith = dealsWith;
        this.idType = idType;
        this.idProof = idProof;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getWholesalerName() {
        return wholesalerName;
    }

    public void setWholesalerName(String wholesalerName) {
        this.wholesalerName = wholesalerName;
    }

    public String getWholesalerContact() {
        return wholesalerContact;
    }

    public void setWholesalerContact(String wholesalerContact) {
        this.wholesalerContact = wholesalerContact;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDealsWith() {
        return dealsWith;
    }

    public void setDealsWith(String dealsWith) {
        this.dealsWith = dealsWith;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public String getIdProof() {
        return idProof;
    }

    public void setIdProof(String idProof) {
        this.idProof = idProof;
    }
}