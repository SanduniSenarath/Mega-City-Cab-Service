/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import model.UserLogin;
import repository.UserLoginServiceImpl;
import service.UserLoginService;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Sanduni
 */
@Path("/users")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserLoginController {

    private final UserLoginService userService = new UserLoginServiceImpl();

    @GET
    @Path("/getAll")
    public Response getAllUsers() {
        List<UserLogin> users = userService.getAllUsers();
        return Response.ok(users, MediaType.APPLICATION_JSON).build();
    }

    @POST
    @Path("/add")
    public Response addUser(UserLogin user) {
        boolean success = userService.addUser(user);
        Map<String, Object> response = new HashMap<>();

        if (success) {
            response.put("success", true);
            response.put("message", "User added successfully");
            return Response.status(Response.Status.CREATED).entity(response).build();
        } else {
            response.put("success", false);
            response.put("message", "Failed to add user");
            return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
        }
    }

    @GET
    @Path("/{id}")
    public Response getUserById(@PathParam("id") int id) {
        UserLogin user = userService.getUserById(id);
        if (user != null) {
            return Response.ok(user, MediaType.APPLICATION_JSON).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND).entity("User not found").build();
        }
    }

    @PUT
    @Path("/update/{id}")
    public Response updateUser(@PathParam("id") int id, UserLogin user) {
        user.setId(id);
        boolean success = userService.updateUser(user);
        Map<String, Object> response = new HashMap<>();

        if (success) {
            response.put("success", true);
            response.put("message", "User updated successfully");
            return Response.ok(response).build();
        } else {
            response.put("success", false);
            response.put("message", "Failed to update user");
            return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
        }
    }

    @DELETE
    @Path("/delete/{id}")
    public Response deleteUser(@PathParam("id") int id) {
        boolean success = userService.deleteUser(id);
        Map<String, Object> response = new HashMap<>();

        if (success) {
            response.put("success", true);
            response.put("message", "User deleted successfully");
            return Response.ok(response).build();
        } else {
            response.put("success", false);
            response.put("message", "Failed to delete user");
            return Response.status(Response.Status.BAD_REQUEST).entity(response).build();
        }
    }
}
