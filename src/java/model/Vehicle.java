/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Sanduni
 */
public class Vehicle {
    private int id;
    private String vehicleNumber;
    private int availableSeats;
    private String type;
    private boolean isAvailable;
    private String owner;
    private String colour;
    private String fuelType;
    private String chassisNumber;
    private String brandName;
    private boolean isDelete;

    // Constructor
    public Vehicle() {
    }

    public Vehicle(int id, String vehicleNumber, int availableSeats, String type, boolean isAvailable, 
                   String owner, String colour, String fuelType, String chassisNumber, 
                   String brandName, boolean isDelete) {
        this.id = id;
        this.vehicleNumber = vehicleNumber;
        this.availableSeats = availableSeats;
        this.type = type;
        this.isAvailable = isAvailable;
        this.owner = owner;
        this.colour = colour;
        this.fuelType = fuelType;
        this.chassisNumber = chassisNumber;
        this.brandName = brandName;
        this.isDelete = isDelete;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public int getAvailableSeats() {
        return availableSeats;
    }

    public void setAvailableSeats(int availableSeats) {
        this.availableSeats = availableSeats;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getColour() {
        return colour;
    }

    public void setColour(String colour) {
        this.colour = colour;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public String getChassisNumber() {
        return chassisNumber;
    }

    public void setChassisNumber(String chassisNumber) {
        this.chassisNumber = chassisNumber;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean isDelete) {
        this.isDelete = isDelete;
    }

    @Override
    public String toString() {
        return "Vehicle{" +
                "id=" + id +
                ", vehicleNumber='" + vehicleNumber + '\'' +
                ", availableSeats=" + availableSeats +
                ", type='" + type + '\'' +
                ", isAvailable=" + isAvailable +
                ", owner='" + owner + '\'' +
                ", colour='" + colour + '\'' +
                ", fuelType='" + fuelType + '\'' +
                ", chassisNumber='" + chassisNumber + '\'' +
                ", brandName='" + brandName + '\'' +
                ", isDelete=" + isDelete +
                '}';
    }
}
