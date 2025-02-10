/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.sql.SQLException;
import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import model.Vehicle;
import service.VehicleService;

/**
 *
 * @author Sanduni
 */

@Path("/books")
@Produces(MediaType.APPLICATION_JSON)  
@Consumes(MediaType.APPLICATION_JSON)  
public class VehicleController {
    
    private final VehicleService bookService = new VehicleService();
    
    @Path("/getAllBooks")
    @GET 
    public Response getBooks(){
        List<Vehicle> books = bookService.getAllBooks();
        return Response.ok(books, MediaType.APPLICATION_JSON).build();
    }
    
    @POST
    public Response addBook(Vehicle book)
    {
        bookService.addBook(book);
        return Response.status(Response.Status.CREATED).build();
    }
    
    @GET
    @Path("/{id}")
    public Vehicle getBook(@PathParam("id") int id)
    {
        return bookService.getBookByID(id);
    }
    
//    @PUT
//    @Path("/{id}")
}
