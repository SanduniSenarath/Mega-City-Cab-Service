/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

/**
 *
 * @author Sanduni
 */
import model.UserLogin;
import java.util.List;

public interface UserLoginService {
    boolean addUser(UserLogin user);
    boolean updateUser(UserLogin user);
    boolean deleteUser(int id);
    UserLogin getUserById(int id);
    List<UserLogin> getAllUsers();
}
