/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package service;

/**
 *
 * @author Sanduni
 */
import model.DriverVehicle;
import java.util.List;

public interface DriverVehicleService {
    boolean addDriverVehicle(DriverVehicle driverVehicle);
    List<DriverVehicle> getAllDriverVehicles();
    DriverVehicle getDriverVehicleByEmpSchNo(int empSchNo);
    boolean updateDriverVehicle(DriverVehicle driverVehicle);
    boolean deleteDriverVehicle(int empSchNo);
    List<DriverVehicle> getAllAvailableDriverVehicles();
}
