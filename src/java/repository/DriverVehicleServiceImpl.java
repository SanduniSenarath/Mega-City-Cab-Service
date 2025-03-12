/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;

/**
 *
 * @author Sanduni
 */
import model.DriverVehicle;
import service.DriverVehicleService;
import util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.SendEmail;

public class DriverVehicleServiceImpl implements DriverVehicleService {

    @Override
    public boolean addDriverVehicle(DriverVehicle driverVehicle) {
        String insertQuery = "INSERT INTO drivervehicle (empSchNo, vehicleno, driverUsername, isavailable) VALUES (?, ?, ?, ?)";
        String updateDriverQuery = "UPDATE driver SET isAvailable = 0 WHERE username = ?";
        String updateVehicleQuery = "UPDATE vehicle SET isAvailable = 0 WHERE vehicle_number = ?";

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            try (PreparedStatement pstmt1 = conn.prepareStatement(insertQuery); PreparedStatement pstmt2 = conn.prepareStatement(updateDriverQuery); PreparedStatement pstmt3 = conn.prepareStatement(updateVehicleQuery)) {

                // Insert into drivervehicle table
                pstmt1.setInt(1, driverVehicle.getEmpSchNo());
                pstmt1.setString(2, driverVehicle.getVehicleNo());
                pstmt1.setString(3, driverVehicle.getDriverUsername());
                pstmt1.setInt(4, 1);
                int insertResult = pstmt1.executeUpdate();

                if (insertResult > 0) {
                    // Update driver availability
                    pstmt2.setString(1, driverVehicle.getDriverUsername());
                    int updateDriverResult = pstmt2.executeUpdate();

                    // Update vehicle availability
                    pstmt3.setString(1, driverVehicle.getVehicleNo());
                    int updateVehicleResult = pstmt3.executeUpdate();

                    // Ensure both updates were successful
                    if (updateDriverResult > 0 && updateVehicleResult > 0) {
                        conn.commit(); // Commit transaction

                        // Fetch email and name for notification
                        DriverServiceImpl driverService = new DriverServiceImpl();
                        String driverEmail = driverService.getDriverEmail(driverVehicle.getDriverUsername());
                        String driverName = driverService.getDriverName(driverVehicle.getDriverUsername()); // Fetch driver name
                        String vehicleNo = driverVehicle.getVehicleNo(); // Get vehicle number

                        // Send assignment email
                        if (driverEmail != null && driverName != null) {
                            SendEmail.sendAssignmentEmail(driverEmail, driverName, vehicleNo);
                        } else {
                            System.out.println("Email or name not found for driver: " + driverVehicle.getDriverUsername());
                        }

                        return true;
                    } else {
                        conn.rollback(); // Rollback if updates fail
                        System.err.println("Failed to update driver or vehicle availability.");
                        return false;
                    }
                } else {
                    conn.rollback(); // Rollback if insert fails
                    System.err.println("Failed to insert into drivervehicle table.");
                    return false;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<DriverVehicle> getAllDriverVehicles() {
        List<DriverVehicle> list = new ArrayList<>();
        String query = "SELECT * FROM drivervehicle";
        try (Connection conn = DBUtil.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                DriverVehicle dv = new DriverVehicle();
                dv.setEmpSchNo(rs.getInt("empSchNo"));
                dv.setVehicleNo(rs.getString("vehicleno"));
                dv.setDriverUsername(rs.getString("driverUsername"));
                dv.setAvailable(rs.getBoolean("isavailable"));
                list.add(dv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public DriverVehicle getDriverVehicleByEmpSchNo(int empSchNo) {
        String query = "SELECT * FROM drivervehicle WHERE empSchNo = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, empSchNo);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                DriverVehicle dv = new DriverVehicle();
                dv.setEmpSchNo(rs.getInt("empSchNo"));
                dv.setVehicleNo(rs.getString("vehicleno"));
                dv.setDriverUsername(rs.getString("driverUsername"));
                dv.setAvailable(rs.getBoolean("isavailable"));
                return dv;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateDriverVehicle(DriverVehicle driverVehicle) {
        Connection conn = null;
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;
        PreparedStatement pstmt3 = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // Step 1: Get the current driver username for the given empSchNo
            String getCurrentDriverQuery = "SELECT driverUsername FROM drivervehicle WHERE empSchNo = ?";
            pstmt1 = conn.prepareStatement(getCurrentDriverQuery);
            pstmt1.setInt(1, driverVehicle.getEmpSchNo());
            rs = pstmt1.executeQuery();

            String oldDriverUsername = null;
            if (rs.next()) {
                oldDriverUsername = rs.getString("driverUsername");
            }

            // Step 2: Update the drivervehicle record
            String updateVehicleQuery = "UPDATE drivervehicle SET vehicleno = ?, driverUsername = ?, isavailable = ? WHERE empSchNo = ?";
            pstmt2 = conn.prepareStatement(updateVehicleQuery);
            pstmt2.setString(1, driverVehicle.getVehicleNo());
            pstmt2.setString(2, driverVehicle.getDriverUsername());
            pstmt2.setBoolean(3, driverVehicle.isAvailable());
            pstmt2.setInt(4, driverVehicle.getEmpSchNo());
            int updateCount = pstmt2.executeUpdate();

            // Step 3: Set the new driver's availability to false
            String updateNewDriverQuery = "UPDATE driver SET isAvailable = 0 WHERE username = ?";
            pstmt3 = conn.prepareStatement(updateNewDriverQuery);
            pstmt3.setString(1, driverVehicle.getDriverUsername());
            pstmt3.executeUpdate();

            // Step 4: Set the old driver's availability to true if it exists
            if (oldDriverUsername != null) {
                String updateOldDriverQuery = "UPDATE driver SET isAvailable = 1 WHERE username = ?";
                pstmt3 = conn.prepareStatement(updateOldDriverQuery);
                pstmt3.setString(1, oldDriverUsername);
                pstmt3.executeUpdate();
            }

            DriverServiceImpl driverService = new DriverServiceImpl();
            String driverEmail = driverService.getDriverEmail(driverVehicle.getDriverUsername());
            String driverName = driverService.getDriverName(driverVehicle.getDriverUsername()); // Fetch driver name
            String vehicleNo = driverVehicle.getVehicleNo(); // Get vehicle number

            // Send assignment email
            if (driverEmail != null && driverName != null) {
                SendEmail.sendAssignmentEmail(driverEmail, driverName, vehicleNo);
            } else {
                System.out.println("Email or name not found for driver: " + driverVehicle.getDriverUsername());
            }

            conn.commit(); // Commit transaction
            return updateCount > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback in case of an error
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt1 != null) {
                    pstmt1.close();
                }
                if (pstmt2 != null) {
                    pstmt2.close();
                }
                if (pstmt3 != null) {
                    pstmt3.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public boolean deleteDriverVehicle(int empSchNo) {
        String query = "DELETE FROM drivervehicle WHERE empSchNo = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, empSchNo);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<DriverVehicle> getAllAvailableDriverVehicles() {
        List<DriverVehicle> list = new ArrayList<>();
        String query = "SELECT * FROM drivervehicle WHERE isavailable = 1"; // Fetch only available vehicles

        try (Connection conn = DBUtil.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                DriverVehicle dv = new DriverVehicle();
                dv.setEmpSchNo(rs.getInt("empSchNo"));
                dv.setVehicleNo(rs.getString("vehicleno"));
                dv.setDriverUsername(rs.getString("driverUsername"));
                dv.setAvailable(rs.getBoolean("isavailable"));
                list.add(dv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
