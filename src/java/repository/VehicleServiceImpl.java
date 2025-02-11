package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Vehicle;
import util.DBUtil;

public class VehicleServiceImpl {

    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        String query = "SELECT * FROM vehicle WHERE isDelete = 0";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setId(rs.getInt("id"));
                vehicle.setVehicleNumber(rs.getString("vehicle_number"));
                vehicle.setAvailableSeats(rs.getInt("available_seats"));
                vehicle.setType(rs.getString("type"));
                vehicle.setAvailable(rs.getBoolean("isAvailable"));
                vehicle.setOwner(rs.getString("owner"));
                vehicle.setColour(rs.getString("colour"));
                vehicle.setFuelType(rs.getString("fuel_type"));
                vehicle.setChassisNumber(rs.getString("chassisNumber"));
                vehicle.setBrandName(rs.getString("brandName"));
                vehicle.setDelete(rs.getBoolean("isDelete"));
                vehicles.add(vehicle);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vehicles;
    }

   public boolean addVehicle(Vehicle vehicle) {
    String query = "INSERT INTO vehicle (vehicle_number, available_seats, type, owner, colour, fuel_type, chassisNumber, brandName, isAvailable, isDelete) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1, 0)";

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {

        pstmt.setString(1, vehicle.getVehicleNumber());
        pstmt.setInt(2, vehicle.getAvailableSeats());
        pstmt.setString(3, vehicle.getType());
        pstmt.setString(4, vehicle.getOwner());
        pstmt.setString(5, vehicle.getColour());
        pstmt.setString(6, vehicle.getFuelType());
        pstmt.setString(7, vehicle.getChassisNumber());
        pstmt.setString(8, vehicle.getBrandName());

        int rowsInserted = pstmt.executeUpdate();
        return rowsInserted > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}


    public Vehicle getVehicleById(int id) {
        String query = "SELECT * FROM vehicle WHERE id = ? AND isDelete = 0";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setId(rs.getInt("id"));
                vehicle.setVehicleNumber(rs.getString("vehicle_number"));
                vehicle.setAvailableSeats(rs.getInt("available_seats"));
                vehicle.setType(rs.getString("type"));
                vehicle.setAvailable(rs.getBoolean("isAvailable"));
                vehicle.setOwner(rs.getString("owner"));
                vehicle.setColour(rs.getString("colour"));
                vehicle.setFuelType(rs.getString("fuel_type"));
                vehicle.setChassisNumber(rs.getString("chassisNumber"));
                vehicle.setBrandName(rs.getString("brandName"));
                vehicle.setDelete(rs.getBoolean("isDelete"));

                return vehicle;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

   public boolean updateVehicle(Vehicle vehicle) {
    String query = "UPDATE vehicle SET vehicle_number = ?, available_seats = ?, type = ?, isAvailable = ?, owner = ?, colour = ?, fuel_type = ?, chassisNumber = ?, brandName = ? WHERE id = ? AND isDelete = 0";

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {

        pstmt.setString(1, vehicle.getVehicleNumber());
        pstmt.setInt(2, vehicle.getAvailableSeats());
        pstmt.setString(3, vehicle.getType());
        pstmt.setBoolean(4, vehicle.isAvailable());  
        pstmt.setString(5, vehicle.getOwner());
        pstmt.setString(6, vehicle.getColour());
        pstmt.setString(7, vehicle.getFuelType());
        pstmt.setString(8, vehicle.getChassisNumber());
        pstmt.setString(9, vehicle.getBrandName());
        pstmt.setInt(10, vehicle.getId());

        int rowsUpdated = pstmt.executeUpdate();
        return rowsUpdated > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}


    public boolean deleteVehicle(int id) {
        String query = "UPDATE vehicle SET isDelete = 1 WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateIsAvailable(int id, boolean isAvailable) {
    String query = "UPDATE vehicle SET isAvailable = ? WHERE id = ? AND isDelete = 0";

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {

        pstmt.setBoolean(1, isAvailable);
        pstmt.setInt(2, id);

        int rowsUpdated = pstmt.executeUpdate();
        return rowsUpdated > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

}
