/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package service;

/**
 *
 * @author Sanduni
 */
import java.util.List;
import model.Schedule;

public interface ScheduleService {

    boolean addSchedule(Schedule schedule);

    boolean updateSchedule(Schedule schedule);

    boolean deleteSchedule(int id);

    List<Schedule> getAllSchedules();

    Schedule getScheduleById(int id);
    
    List<Schedule> getSchedulesByUsername(String username);
}

