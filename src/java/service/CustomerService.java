/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package service;

import model.Customer;

import java.util.List;

/**
 *
 * @author Sanduni
 */
public interface CustomerService {

    // Get all customers
    List<Customer> getAllCustomers();

    // Add a new customer
    boolean addCustomer(Customer customer);

    // Get a customer by ID
    Customer getCustomerById(int id);

    // Update an existing customer
    boolean updateCustomer(Customer customer);

    // Delete a customer (soft delete by setting isDelete to 1)
    boolean deleteCustomer(int id);

    // Get a customer by username
    Customer getCustomerByUsername(String username);

// Update a customer by username
    boolean updateCustomerByUsername(Customer customer);

}
