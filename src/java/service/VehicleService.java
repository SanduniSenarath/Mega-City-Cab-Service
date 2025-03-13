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

    
    List<Vehicle> getAllVehicles();

    
    boolean addVehicle(Vehicle vehicle);

   
    Vehicle getVehicleById(int id);

    
    boolean updateVehicle(Vehicle vehicle);

    
    boolean deleteVehicle(int id);
}
