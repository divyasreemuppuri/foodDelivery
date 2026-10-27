package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderDAO;
import com.tap.model.Order;
import com.tap.utility.DBConnection;

public class OrderDAOImpl implements OrderDAO {

	@Override
	public int addOrder(Order order) {

	    String sql = "INSERT INTO `Order` "
	               + "(userId, restaurantId, orderDate, totalAmount, status, paymentMode) "
	               + "VALUES (?, ?, ?, ?, ?, ?)";

	    int generatedOrderId = 0;

	    try (Connection connection = DBConnection.getConnection();
	         PreparedStatement statement = connection.prepareStatement(
	             sql,
	             java.sql.Statement.RETURN_GENERATED_KEYS
	         )) {

	        statement.setInt(1, order.getUserId());
	        statement.setInt(2, order.getRestaurantId());
	        statement.setTimestamp(3, order.getOrderDate());
	        statement.setDouble(4, order.getTotalAmount());
	        statement.setString(5, order.getStatus());
	        statement.setString(6, order.getPaymentMode());

	        statement.executeUpdate();

	        try (ResultSet resultSet = statement.getGeneratedKeys()) {

	            if (resultSet.next()) {

	                generatedOrderId = resultSet.getInt(1);

	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return generatedOrderId;
	}

    @Override
    public Order getOrder(int orderId) {

        String sql = "SELECT * FROM `Order` WHERE orderId = ?";
        Order order = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    order = new Order(
                        resultSet.getInt("orderId"),
                        resultSet.getInt("userId"),
                        resultSet.getInt("restaurantId"),
                        resultSet.getTimestamp("orderDate"),
                        resultSet.getDouble("totalAmount"),
                        resultSet.getString("status"),
                        resultSet.getString("paymentMode")
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }

    @Override
    public List<Order> getAllOrders() {

        String sql = "SELECT * FROM `Order`";
        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Order order = new Order(
                    resultSet.getInt("orderId"),
                    resultSet.getInt("userId"),
                    resultSet.getInt("restaurantId"),
                    resultSet.getTimestamp("orderDate"),
                    resultSet.getDouble("totalAmount"),
                    resultSet.getString("status"),
                    resultSet.getString("paymentMode")
                );

                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {

        String sql = "SELECT * FROM `Order` WHERE userId = ?";
        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Order order = new Order(
                        resultSet.getInt("orderId"),
                        resultSet.getInt("userId"),
                        resultSet.getInt("restaurantId"),
                        resultSet.getTimestamp("orderDate"),
                        resultSet.getDouble("totalAmount"),
                        resultSet.getString("status"),
                        resultSet.getString("paymentMode")
                    );

                    orders.add(order);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public List<Order> getOrdersByRestaurant(int restaurantId) {

        String sql = "SELECT * FROM `Order` WHERE restaurantId = ?";
        List<Order> orders = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, restaurantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Order order = new Order(
                        resultSet.getInt("orderId"),
                        resultSet.getInt("userId"),
                        resultSet.getInt("restaurantId"),
                        resultSet.getTimestamp("orderDate"),
                        resultSet.getDouble("totalAmount"),
                        resultSet.getString("status"),
                        resultSet.getString("paymentMode")
                    );

                    orders.add(order);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public void updateOrder(Order order) {

        String sql = "UPDATE `Order` SET "
                   + "userId = ?, restaurantId = ?, orderDate = ?, "
                   + "totalAmount = ?, status = ?, paymentMode = ? "
                   + "WHERE orderId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, order.getUserId());
            statement.setInt(2, order.getRestaurantId());
            statement.setTimestamp(3, order.getOrderDate());
            statement.setDouble(4, order.getTotalAmount());
            statement.setString(5, order.getStatus());
            statement.setString(6, order.getPaymentMode());
            statement.setInt(7, order.getOrderId());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateOrderStatus(int orderId, String status) {

        String sql = "UPDATE `Order` SET status = ? WHERE orderId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setInt(2, orderId);

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(int orderId) {

        String sql = "DELETE FROM `Order` WHERE orderId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}