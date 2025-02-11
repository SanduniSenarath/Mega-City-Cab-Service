/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package service;

import java.util.List;
import model.Vehicle;

/**
 *
 * @author Sanduni
 */
public interface VehicleService {
    // Retrieve all active vehicles (where isDelete = 0)
    List<Vehicle> getAllVehicles();

    // Add a new vehicle
    boolean addVehicle(Vehicle vehicle);

    // Retrieve a vehicle by ID (excluding deleted ones)
    Vehicle getVehicleById(int id);

    // Update vehicle details
    boolean updateVehicle(Vehicle vehicle);

    // Soft delete a vehicle (set isDelete = 1)
    boolean deleteVehicle(int id);
}
