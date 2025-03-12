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
import model.Price;
import repository.PriceServiceImpl;

@Path("/prices")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class PriceController {

    private final PriceServiceImpl priceService = new PriceServiceImpl();

    @GET
    @Path("/getAll")
    public Response getAllPrices() {
        List<Price> prices = priceService.getAllPrices();
        return Response.ok(prices, MediaType.APPLICATION_JSON).build();
    }

    @GET
    @Path("/{id}")
    public Response getPriceById(@PathParam("id") int id) {
        Price price = priceService.getPriceById(id);
        if (price != null) {
            return Response.ok(price, MediaType.APPLICATION_JSON).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("Price not found").build();
        }
    }

    @PUT
    @Path("/update/{id}")
    public Response updatePrice(@PathParam("id") int id, Price price) {
        price.setId(id);
        boolean success = priceService.updatePrice(price);
        if (success) {
            return Response.ok("Price updated successfully").build();
        } else {
            return Response.status(Response.Status.BAD_REQUEST).entity("Failed to update price").build();
        }
    }
}
