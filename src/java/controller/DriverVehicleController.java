/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author Sanduni
 */
import model.DriverVehicle;
import repository.DriverVehicleServiceImpl;
import service.DriverVehicleService;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/drivervehicle")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class DriverVehicleController {

    private final DriverVehicleService service = new DriverVehicleServiceImpl();

    @POST
    @Path("/add")
    public Response addDriverVehicle(DriverVehicle driverVehicle) {
        boolean success = service.addDriverVehicle(driverVehicle);
        return success ? Response.status(Response.Status.CREATED).entity("DriverVehicle added successfully").build()
                        : Response.status(Response.Status.BAD_REQUEST).entity("Failed to add DriverVehicle").build();
    }

    @GET
    @Path("/getAll")
    public Response getAllDriverVehicles() {
        List<DriverVehicle> list = service.getAllDriverVehicles();
        return Response.ok(list, MediaType.APPLICATION_JSON).build();
    }

    @GET
    @Path("/{empSchNo}")
    public Response getDriverVehicleByEmpSchNo(@PathParam("empSchNo") int empSchNo) {
        DriverVehicle dv = service.getDriverVehicleByEmpSchNo(empSchNo);
        return dv != null ? Response.ok(dv, MediaType.APPLICATION_JSON).build()
                          : Response.status(Response.Status.NOT_FOUND).entity("DriverVehicle not found").build();
    }

    @PUT
    @Path("/update/{empSchNo}")
    public Response updateDriverVehicle(@PathParam("empSchNo") int empSchNo, DriverVehicle driverVehicle) {
        driverVehicle.setEmpSchNo(empSchNo);
        boolean success = service.updateDriverVehicle(driverVehicle);
        return success ? Response.ok("DriverVehicle updated successfully").build()
                        : Response.status(Response.Status.BAD_REQUEST).entity("Failed to update DriverVehicle").build();
    }

    @DELETE
    @Path("/delete/{empSchNo}")
    public Response deleteDriverVehicle(@PathParam("empSchNo") int empSchNo) {
        boolean success = service.deleteDriverVehicle(empSchNo);
        return success ? Response.ok("DriverVehicle deleted successfully").build()
                        : Response.status(Response.Status.BAD_REQUEST).entity("Failed to delete DriverVehicle").build();
    }
    
    @GET
    @Path("/available")
    public Response getAllAvailableDriverVehicles() {
        List<DriverVehicle> list = service.getAllAvailableDriverVehicles();
        return Response.ok(list, MediaType.APPLICATION_JSON).build();
    }
}
