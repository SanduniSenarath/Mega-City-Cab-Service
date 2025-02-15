package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import model.Vehicle;
import repository.VehicleServiceImpl;

@Path("/vehicles")
@Produces(MediaType.APPLICATION_JSON)  
@Consumes(MediaType.APPLICATION_JSON)  
public class VehicleController {
    
    private final VehicleServiceImpl vehicleService = new VehicleServiceImpl();
    
    @GET
    @Path("/getAll")
    public Response getAllVehicles() {
        List<Vehicle> vehicles = vehicleService.getAllVehicles();
        return Response.ok(vehicles, MediaType.APPLICATION_JSON).build();
    }
    
    @POST
    @Path("/add")
    public Response addVehicle(Vehicle vehicle) {
        boolean success = vehicleService.addVehicle(vehicle);
        Map<String, Object> response = new HashMap<>();

    if (success) {
        response.put("success", true);
        response.put("message", "Vehicle added successfully");
        return Response.status(Response.Status.CREATED).entity(response).build();
    } else {
        response.put("success", false);
        response.put("message", "Failed to add vehicle");
        return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
    }
    }

    @GET
    @Path("/{id}")
    public Response getVehicleById(@PathParam("id") int id) {
        Vehicle vehicle = vehicleService.getVehicleById(id);
        if (vehicle != null) {
            return Response.ok(vehicle, MediaType.APPLICATION_JSON).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("Vehicle not found").build();
        }
    }

    @PUT
    @Path("/update/{id}")
    public Response updateVehicle(@PathParam("id") int id, Vehicle vehicle) {
        vehicle.setId(id);
boolean success = vehicleService.updateVehicle(vehicle);

Map<String, Object> response = new HashMap<>();
if (success) {
    response.put("success", true);
    response.put("message", "Vehicle updated successfully");
    return Response.ok(response).build();
} else {
    response.put("success", false);
    response.put("message", "Failed to update vehicle");
    return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
}

    }

    @DELETE
    @Path("/delete/{id}")
    public Response deleteVehicle(@PathParam("id") int id) {
        boolean success = vehicleService.deleteVehicle(id);
         Map<String, Object> response = new HashMap<>();

    if (success) {
        response.put("success", true);
        response.put("message", "Vehicle added successfully");
        return Response.status(Response.Status.CREATED).entity(response).build();
    } else {
        response.put("success", false);
        response.put("message", "Failed to add vehicle");
        return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
    }
    }
    
    
}
