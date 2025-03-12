/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package service;

/**
 *
 * @author Sanduni
 */
import java.util.List;
import model.Price;

public interface PriceService {

    List<Price> getAllPrices();

    Price getPriceById(int id);

    boolean updatePrice(Price price);
}
