package com.tap.DAO;

import com.tap.model.Order;
import java.util.List;

public interface OrderDAO {

    int addOrder(Order order);

    Order getOrder(int orderId);

    List<Order> getAllOrders();

    List<Order> getOrdersByUser(int userId);

    List<Order> getOrdersByRestaurant(int restaurantId);

    void updateOrder(Order order);

    void updateOrderStatus(int orderId, String status);

    void deleteOrder(int orderId);
}