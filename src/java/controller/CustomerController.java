/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import model.Customer;
import repository.CustomerServiceImpl; 
import service.CustomerService;
/**
 *
 * @author Sanduni
 */

@Path("/customers")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class CustomerController {

    private final CustomerService customerService = new CustomerServiceImpl();

    @GET
    @Path("/getAll")
    public Response getAllCustomers() {
        List<Customer> customers = customerService.getAllCustomers();
        return Response.ok(customers, MediaType.APPLICATION_JSON).build();
    }

    @POST
    @Path("/add")
    public Response addCustomer(Customer customer) {
        boolean success = customerService.addCustomer(customer);
        Map<String, Object> response = new HashMap<>();

        if (success) {
            response.put("success", true);
            response.put("message", "Customer added successfully");
            return Response.status(Response.Status.CREATED).entity(response).build();
        } else {
            response.put("success", false);
            response.put("message", "Failed to add customer");
            return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
        }
    }

    @GET
    @Path("/{id}")
    public Response getCustomerById(@PathParam("id") int id) {
        Customer customer = customerService.getCustomerById(id);
        if (customer != null) {
            return Response.ok(customer, MediaType.APPLICATION_JSON).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("Customer not found").build();
        }
    }

    @PUT
    @Path("/update/{id}")
    public Response updateCustomer(@PathParam("id") int id, Customer customer) {
        customer.setId(id);
        boolean success = customerService.updateCustomer(customer);

        Map<String, Object> response = new HashMap<>();
        if (success) {
            response.put("success", true);
            response.put("message", "Customer updated successfully");
            return Response.ok(response).build();
        } else {
            response.put("success", false);
            response.put("message", "Failed to update customer");
            return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
        }
    }

    @DELETE
    @Path("/delete/{id}")
    public Response deleteCustomer(@PathParam("id") int id) {
        boolean success = customerService.deleteCustomer(id);
        Map<String, Object> response = new HashMap<>();

        if (success) {
            response.put("success", true);
            response.put("message", "Customer deleted successfully");
            return Response.ok(response).build();
        } else {
            response.put("success", false);
            response.put("message", "Failed to delete customer");
            return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
        }
    }
    
    @GET
@Path("/username/{username}")
public Response getCustomerByUsername(@PathParam("username") String username) {
    Customer customer = customerService.getCustomerByUsername(username);
    if (customer != null) {
        return Response.ok(customer, MediaType.APPLICATION_JSON).build();
    } else {
        return Response.status(Response.Status.NOT_FOUND).entity("Customer not found").build();
    }
}

@PUT
@Path("/update/username/{username}")
public Response updateCustomerByUsername(@PathParam("username") String username, Customer customer) {
    customer.setUsername(username);
    boolean success = customerService.updateCustomerByUsername(customer);

    Map<String, Object> response = new HashMap<>();
    if (success) {
        response.put("success", true);
        response.put("message", "Customer updated successfully");
        return Response.ok(response).build();
    } else {
        response.put("success", false);
        response.put("message", "Failed to update customer");
        return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
    }
}

}