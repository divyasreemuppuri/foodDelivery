package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public void addRestaurant(Restaurant restaurant) {

        String sql = "INSERT INTO Restaurant "
                   + "(name, cuisineType, deliveryTime, address, adminUserId, "
                   + "rating, isActive, imagePath) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, restaurant.getName());
            statement.setString(2, restaurant.getCuisineType());
            statement.setInt(3, restaurant.getDeliveryTime());
            statement.setString(4, restaurant.getAddress());
            statement.setInt(5, restaurant.getAdminUserId());
            statement.setDouble(6, restaurant.getRating());
            statement.setBoolean(7, restaurant.isActive());
            statement.setString(8, restaurant.getImagePath());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {

        String sql = "SELECT * FROM Restaurant WHERE restaurantId = ?";
        Restaurant restaurant = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, restaurantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    restaurant = new Restaurant(
                        resultSet.getInt("restaurantId"),
                        resultSet.getString("name"),
                        resultSet.getString("cuisineType"),
                        resultSet.getInt("deliveryTime"),
                        resultSet.getString("address"),
                        resultSet.getInt("adminUserId"),
                        resultSet.getDouble("rating"),
                        resultSet.getBoolean("isActive"),
                        resultSet.getString("imagePath")
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurant;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {

        String sql = "SELECT * FROM Restaurant";
        List<Restaurant> restaurants = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Restaurant restaurant = new Restaurant(
                    resultSet.getInt("restaurantId"),
                    resultSet.getString("name"),
                    resultSet.getString("cuisineType"),
                    resultSet.getInt("deliveryTime"),
                    resultSet.getString("address"),
                    resultSet.getInt("adminUserId"),
                    resultSet.getDouble("rating"),
                    resultSet.getBoolean("isActive"),
                    resultSet.getString("imagePath")
                );

                restaurants.add(restaurant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurants;
    }

    @Override
    public void updateRestaurant(Restaurant restaurant) {

        String sql = "UPDATE Restaurant SET "
                   + "name = ?, cuisineType = ?, deliveryTime = ?, "
                   + "address = ?, adminUserId = ?, rating = ?, "
                   + "isActive = ?, imagePath = ? "
                   + "WHERE restaurantId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, restaurant.getName());
            statement.setString(2, restaurant.getCuisineType());
            statement.setInt(3, restaurant.getDeliveryTime());
            statement.setString(4, restaurant.getAddress());
            statement.setInt(5, restaurant.getAdminUserId());
            statement.setDouble(6, restaurant.getRating());
            statement.setBoolean(7, restaurant.isActive());
            statement.setString(8, restaurant.getImagePath());
            statement.setInt(9, restaurant.getRestaurantId());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int restaurantId) {

        String sql = "DELETE FROM Restaurant WHERE restaurantId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, restaurantId);

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}