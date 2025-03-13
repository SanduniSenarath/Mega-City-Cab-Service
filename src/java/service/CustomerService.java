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

    List<Customer> getAllCustomers();

    boolean addCustomer(Customer customer);

    Customer getCustomerById(int id);

    boolean updateCustomer(Customer customer);

    boolean deleteCustomer(int id);

    Customer getCustomerByUsername(String username);

    boolean updateCustomerByUsername(Customer customer);

}
