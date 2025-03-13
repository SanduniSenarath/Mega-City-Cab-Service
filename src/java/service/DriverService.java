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

    
    List<Driver> getAllDrivers();

    
    boolean addDriver(Driver driver);

   
    Driver getDriverById(int id);

    
    boolean updateDriver(Driver driver);

    
    boolean deleteDriver(int id);

    List<Driver> getAvailableDrivers();

}
