/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Sanduni
 */

public class Driver {
    private int id;
    private String nic;
    private String name;
    private String phoneNo;
    private String addressNo;
    private String addressLine1;
    private String addressLine2;
    private String gender;
    private boolean isDelete;
    private boolean isAvailable;
    private String email; 
    private String username;  

    
    public Driver() {}

   
    public Driver(int id, String nic, String name, String phoneNo, String addressNo, String addressLine1,
                  String addressLine2, String gender, boolean isDelete, boolean isAvailable, String email, String username) {
        this.id = id;
        this.nic = nic;
        this.name = name;
        this.phoneNo = phoneNo;
        this.addressNo = addressNo;
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.gender = gender;
        this.isDelete = isDelete;
        this.isAvailable = isAvailable;
        this.email = email;  
        this.username = username;  
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getAddressNo() {
        return addressNo;
    }

    public void setAddressNo(String addressNo) {
        this.addressNo = addressNo;
    }

    public String getAddressLine1() {
        return addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    public String getAddressLine2() {
        return addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean delete) {
        isDelete = delete;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public String getEmail() {
        return email;  
    }

    public void setEmail(String email) {
        this.email = email;  
    }

    public String getUsername() {
        return username; 
    }

    public void setUsername(String username) {
        this.username = username; 
    }

    // toString method
    @Override
    public String toString() {
        return "Driver{" +
                "id=" + id +
                ", nic='" + nic + '\'' +
                ", name='" + name + '\'' +
                ", phoneNo='" + phoneNo + '\'' +
                ", addressNo='" + addressNo + '\'' +
                ", addressLine1='" + addressLine1 + '\'' +
                ", addressLine2='" + addressLine2 + '\'' +
                ", gender='" + gender + '\'' +
                ", isDelete=" + isDelete +
                ", isAvailable=" + isAvailable +
                ", email='" + email + '\'' +
                ", username='" + username + '\'' + 
                '}';
    }
}
