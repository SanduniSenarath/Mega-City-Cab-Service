/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author Sanduni
 */
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import model.Schedule;
import repository.ScheduleServiceImpl;

@Path("/schedules")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ScheduleController {

    private final ScheduleServiceImpl scheduleService = new ScheduleServiceImpl();

    // Get all schedules
    @GET
    @Path("/getAll")
    public Response getAllSchedules() {
        List<Schedule> schedules = scheduleService.getAllSchedules();
        return Response.ok(schedules, MediaType.APPLICATION_JSON).build();
    }

    // Add a new schedule
    @POST
    @Path("/add")
    public Response addSchedule(Schedule schedule) {
        boolean success = scheduleService.addSchedule(schedule);
        Map<String, Object> response = new HashMap<>();

        if (success) {
            response.put("success", true);
            response.put("message", "Schedule added successfully");
            return Response.status(Response.Status.CREATED).entity(response).build();
        } else {
            response.put("success", false);
            response.put("message", "Failed to add schedule");
            return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
        }
    }

    // Get a schedule by ID
    @GET
    @Path("/{id}")
    public Response getScheduleById(@PathParam("id") int id) {
        Schedule schedule = scheduleService.getScheduleById(id);
        if (schedule != null) {
            return Response.ok(schedule, MediaType.APPLICATION_JSON).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("Schedule not found").build();
        }
    }

    // In ScheduleResource.java
    @GET
    @Path("/username/{username}")
    public Response getSchedulesByUsername(@PathParam("username") String username) {
        List<Schedule> schedules = scheduleService.getSchedulesByUsername(username);
        if (schedules != null && !schedules.isEmpty()) {
            return Response.ok(schedules, MediaType.APPLICATION_JSON).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("No schedules found for the username").build();
        }
    }

    // Update a schedule
    @PUT
    @Path("/update/{id}")
    public Response updateSchedule(@PathParam("id") int id, Schedule schedule) {
        schedule.setId(id);
        boolean success = scheduleService.updateSchedule(schedule);
        if (success) {
            return Response.ok("Schedule updated successfully").build();
        } else {
            return Response.status(Response.Status.BAD_REQUEST).entity("Failed to update schedule").build();
        }
    }

    // Delete a schedule (soft delete)
    @DELETE
    @Path("/delete/{id}")
    public Response deleteSchedule(@PathParam("id") int id) {
        boolean success = scheduleService.deleteSchedule(id);
        if (success) {
            return Response.ok("Schedule deleted successfully (soft delete)").build();
        } else {
            return Response.status(Response.Status.BAD_REQUEST).entity("Failed to delete schedule").build();
        }
    }
}
