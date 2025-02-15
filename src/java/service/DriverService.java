/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package service;

import java.util.List;
import model.Driver;

/**
 *
 * @author Sanduni
 */
public interface DriverService {
    // Retrieve all active drivers (where isDelete = 0)
    List<Driver> getAllDrivers();

    // Add a new driver
    boolean addDriver(Driver driver);

    // Retrieve a driver by ID (excluding deleted ones)
    Driver getDriverById(int id);

    // Update driver details
    boolean updateDriver(Driver driver);

    // Soft delete a driver (set isDelete = 1)
    boolean deleteDriver(int id);
}
