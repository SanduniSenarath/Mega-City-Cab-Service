/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;

/**
 *
 * @author Sanduni
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import model.Schedule;
import service.CustomerService;
import service.ScheduleService;
import util.DBUtil;
import util.SendEmail;

public class ScheduleServiceImpl implements ScheduleService {

    private Connection connection;

    public ScheduleServiceImpl() {
        try {
            this.connection = DBUtil.getConnection();
        } catch (SQLException ex) {
            Logger.getLogger(DriverServiceImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public boolean addSchedule(Schedule schedule) {
        String query = "INSERT INTO schedule (bookNumber, startLocation, endLocation, distance, amount, empSchNo, username, date, time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, schedule.getBookNumber());
            stmt.setString(2, schedule.getStartLocation());
            stmt.setString(3, schedule.getEndLocation());
            stmt.setDouble(4, schedule.getDistance());
            stmt.setDouble(5, schedule.getAmount());
            stmt.setString(6, schedule.getEmpSchNo());
            stmt.setString(7, schedule.getUsername());
            stmt.setString(8, schedule.getDate());
            stmt.setString(9, schedule.getTime());

            int result = stmt.executeUpdate();

            if (result > 0) {
                
                CustomerService customerService = new CustomerServiceImpl();
                Customer customer = customerService.getCustomerByUsername(schedule.getUsername());

                if (customer != null) {
                    
                    SendEmail.sendBookingConfirmationEmail(
                            customer.getEmail(),
                            customer.getName(),
                            schedule.getDate(), 
                            schedule.getStartLocation(), 
                            schedule.getEndLocation(), 
                            schedule.getDistance(), 
                            schedule.getAmount(), 
                            schedule.getBookNumber() 
                    );
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateSchedule(Schedule schedule) {
        String query = "UPDATE schedule SET bookNumber = ?, startLocation = ?, endLocation = ?, distance = ?, amount = ?, empSchNo = ?, username = ?, date = ?, time = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, schedule.getBookNumber());
            stmt.setString(2, schedule.getStartLocation());
            stmt.setString(3, schedule.getEndLocation());
            stmt.setDouble(4, schedule.getDistance());
            stmt.setDouble(5, schedule.getAmount());
            stmt.setString(6, schedule.getEmpSchNo());
            stmt.setString(7, schedule.getUsername());
            stmt.setString(8, schedule.getDate());
            stmt.setString(9, schedule.getTime());
            stmt.setInt(10, schedule.getId());

            int result = stmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteSchedule(int id) {
        String query = "DELETE FROM schedule WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            int result = stmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Schedule> getAllSchedules() {
        List<Schedule> schedules = new ArrayList<>();
        String query = "SELECT * FROM schedule";
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setId(rs.getInt("id"));
                schedule.setBookNumber(rs.getString("bookNumber"));
                schedule.setStartLocation(rs.getString("startLocation"));
                schedule.setEndLocation(rs.getString("endLocation"));
                schedule.setDistance(rs.getDouble("distance"));
                schedule.setAmount(rs.getDouble("amount"));
                schedule.setEmpSchNo(rs.getString("empSchNo"));
                schedule.setUsername(rs.getString("username"));
                schedule.setDate(rs.getString("date"));
                schedule.setTime(rs.getString("time"));
                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }

    @Override
    public Schedule getScheduleById(int id) {
        String query = "SELECT * FROM schedule WHERE id = ?";
        Schedule schedule = null;
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                schedule = new Schedule();
                schedule.setId(rs.getInt("id"));
                schedule.setBookNumber(rs.getString("bookNumber"));
                schedule.setStartLocation(rs.getString("startLocation"));
                schedule.setEndLocation(rs.getString("endLocation"));
                schedule.setDistance(rs.getDouble("distance"));
                schedule.setAmount(rs.getDouble("amount"));
                schedule.setEmpSchNo(rs.getString("empSchNo"));
                schedule.setUsername(rs.getString("username"));
                schedule.setDate(rs.getString("date"));
                schedule.setTime(rs.getString("time"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedule;
    }

    @Override
    public List<Schedule> getSchedulesByUsername(String username) {
        List<Schedule> schedules = new ArrayList<>();
        String query = "SELECT * FROM schedule WHERE username = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setId(rs.getInt("id"));
                schedule.setBookNumber(rs.getString("bookNumber"));
                schedule.setStartLocation(rs.getString("startLocation"));
                schedule.setEndLocation(rs.getString("endLocation"));
                schedule.setDistance(rs.getDouble("distance"));
                schedule.setAmount(rs.getDouble("amount"));
                schedule.setEmpSchNo(rs.getString("empSchNo"));
                schedule.setUsername(rs.getString("username"));
                schedule.setDate(rs.getString("date"));
                schedule.setTime(rs.getString("time"));
                schedules.add(schedule);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }

}
