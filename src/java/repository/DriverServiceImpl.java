package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Driver;
import service.DriverService;
import util.DBUtil;
import util.SendEmail;

/**
 *
 * @author Sanduni
 */
public class DriverServiceImpl implements DriverService {
    private Connection connection;

    public DriverServiceImpl() {
        try {
            this.connection = DBUtil.getConnection();
        } catch (SQLException ex) {
            Logger.getLogger(DriverServiceImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public List<Driver> getAllDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String query = "SELECT * FROM driver WHERE isDelete = 0";
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                drivers.add(new Driver(
                        rs.getInt("id"),
                        rs.getString("nic"),
                        rs.getString("name"),
                        rs.getString("phoneno"),
                        rs.getString("addressno"),
                        rs.getString("addressLine1"),
                        rs.getString("addressLine2"),
                        rs.getString("gender"),
                        rs.getBoolean("isDelete"),
                        rs.getBoolean("isAvailable"),
                        rs.getString("email"),  // Added email field
                        rs.getString("username")  // Added username field
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drivers;
    }

    @Override
    public boolean addDriver(Driver driver) {
        String query = "INSERT INTO driver (nic, name, phoneno, addressno, addressLine1, addressLine2, gender, isDelete, isAvailable, email, username) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, driver.getNic());
            stmt.setString(2, driver.getName());
            stmt.setString(3, driver.getPhoneNo());
            stmt.setString(4, driver.getAddressNo());
            stmt.setString(5, driver.getAddressLine1());
            stmt.setString(6, driver.getAddressLine2());
            stmt.setString(7, driver.getGender());
            stmt.setBoolean(8, driver.isDelete());
            stmt.setBoolean(9, driver.isAvailable());
            stmt.setString(10, driver.getEmail());  // Set email field
            stmt.setString(11, driver.getUsername());  // Set username field
            
            int rowsAffected = stmt.executeUpdate();
        
            if (rowsAffected > 0) {
                SendEmail.sendEmail(driver.getEmail(), driver.getName());
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Driver getDriverById(int id) {
        String query = "SELECT * FROM driver WHERE id = ? AND isDelete = 0";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Driver(
                            rs.getInt("id"),
                            rs.getString("nic"),
                            rs.getString("name"),
                            rs.getString("phoneno"),
                            rs.getString("addressno"),
                            rs.getString("addressLine1"),
                            rs.getString("addressLine2"),
                            rs.getString("gender"),
                            rs.getBoolean("isDelete"),
                            rs.getBoolean("isAvailable"),
                            rs.getString("email"),  // Get email field
                            rs.getString("username")  // Get username field
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateDriver(Driver driver) {
        String query = "UPDATE driver SET nic = ?, name = ?, phoneno = ?, addressno = ?, addressLine1 = ?, addressLine2 = ?, gender = ?, isAvailable = ?, email = ?, username = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, driver.getNic());
            stmt.setString(2, driver.getName());
            stmt.setString(3, driver.getPhoneNo());
            stmt.setString(4, driver.getAddressNo());
            stmt.setString(5, driver.getAddressLine1());
            stmt.setString(6, driver.getAddressLine2());
            stmt.setString(7, driver.getGender());
            stmt.setBoolean(8, driver.isAvailable());
            stmt.setString(9, driver.getEmail());  // Set email field
            stmt.setString(10, driver.getUsername());  // Set username field
            stmt.setInt(11, driver.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteDriver(int id) {
        String query = "UPDATE driver SET isDelete = 1 WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
