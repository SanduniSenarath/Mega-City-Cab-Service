package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import model.Driver;
import repository.DriverServiceImpl;

@Path("/drivers")
@Produces(MediaType.APPLICATION_JSON)  
@Consumes(MediaType.APPLICATION_JSON)  
public class DriverController {
    
    private final DriverServiceImpl driverService = new DriverServiceImpl();
    
    @GET
    @Path("/getAll")
    public Response getAllDrivers() {
        List<Driver> drivers = driverService.getAllDrivers();
        return Response.ok(drivers, MediaType.APPLICATION_JSON).build();
    }
    
    @POST
    @Path("/add")
    public Response addDriver(Driver driver) {
        boolean success = driverService.addDriver(driver);
         Map<String, Object> response = new HashMap<>();

    if (success) {
        response.put("success", true);
        response.put("message", "Driver added successfully");
        return Response.status(Response.Status.CREATED).entity(response).build();
    } else {
        response.put("success", false);
        response.put("message", "Failed to add driver");
        return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
    }
    }

    @GET
    @Path("/{id}")
    public Response getDriverById(@PathParam("id") int id) {
        Driver driver = driverService.getDriverById(id);
        if (driver != null) {
            return Response.ok(driver, MediaType.APPLICATION_JSON).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("Driver not found").build();
        }
    }

    @PUT
    @Path("/update/{id}")
    public Response updateDriver(@PathParam("id") int id, Driver driver) {
        driver.setId(id);
        boolean success = driverService.updateDriver(driver);
        if (success) {
            return Response.ok("Driver updated successfully").build();
        } else {
            return Response.status(Response.Status.BAD_REQUEST).entity("Failed to update driver").build();
        }
    }

    @DELETE
    @Path("/delete/{id}")
    public Response deleteDriver(@PathParam("id") int id) {
        boolean success = driverService.deleteDriver(id);
        if (success) {
            return Response.ok("Driver deleted successfully (soft delete)").build();
        } else {
            return Response.status(Response.Status.BAD_REQUEST).entity("Failed to delete driver").build();
        }
    }
}
