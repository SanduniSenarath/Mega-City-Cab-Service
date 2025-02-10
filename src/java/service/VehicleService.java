/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Vehicle;
import util.DBUtil;

/**
 *
 * @author Sanduni
 */
public class VehicleService {
    public  List<Vehicle> getAllBooks()
    {
        List<Vehicle> books = new ArrayList();
        String query = "SELECT * FROM books";
        
        try
            (Connection conn = DBUtil.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query))
            {
               while (rs.next()) {
                   Vehicle book = new Vehicle();
                   book.setId(rs.getInt("id"));
                   book.setTitle(rs.getString("title"));
                   book.setAuthor(rs.getString("author"));
                   book.setAvailable(rs.getBoolean("is_available"));
                   books.add(book);
               }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return books;
    }
    
    public boolean addBook(Vehicle book) {
        String query = "INSERT INTO books (title, author, is_available) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setBoolean(3, book.isAvailable());
            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Vehicle getBookByID(int id) {
        String query = "SELECT * FROM books WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Vehicle book = new Vehicle();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setAvailable(rs.getBoolean("is_available"));
                return book;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;  
    }

    public boolean updateBook(Vehicle book) {
        String query = "UPDATE books SET title = ?, author = ?, is_available = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor()); 
            pstmt.setBoolean(3, book.isAvailable());
            pstmt.setInt(4, book.getId());
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteBook(int id) {
        String query = "DELETE FROM books WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
}
