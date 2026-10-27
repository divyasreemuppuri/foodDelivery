package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.MenuDAO;
import com.tap.model.Menu;
import com.tap.utility.DBConnection;

public class MenuDAOImpl implements MenuDAO {

    @Override
    public void addMenu(Menu menu) {

        String sql = "INSERT INTO Menu "
                   + "(restaurantId, itemName, description, price, isAvailable, imagePath) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, menu.getRestaurantId());
            statement.setString(2, menu.getItemName());
            statement.setString(3, menu.getDescription());
            statement.setDouble(4, menu.getPrice());
            statement.setBoolean(5, menu.isAvailable());
            statement.setString(6, menu.getImagePath());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenu(int menuId) {

        String sql = "SELECT * FROM Menu WHERE menuId = ?";
        Menu menu = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, menuId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    menu = new Menu(
                        resultSet.getInt("menuId"),
                        resultSet.getInt("restaurantId"),
                        resultSet.getString("itemName"),
                        resultSet.getString("description"),
                        resultSet.getDouble("price"),
                        resultSet.getBoolean("isAvailable"),
                        resultSet.getString("imagePath")
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menu;
    }

    @Override
    public List<Menu> getAllMenus() {

        String sql = "SELECT * FROM Menu";
        List<Menu> menus = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Menu menu = new Menu(
                    resultSet.getInt("menuId"),
                    resultSet.getInt("restaurantId"),
                    resultSet.getString("itemName"),
                    resultSet.getString("description"),
                    resultSet.getDouble("price"),
                    resultSet.getBoolean("isAvailable"),
                    resultSet.getString("imagePath")
                );

                menus.add(menu);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menus;
    }

    @Override
    public List<Menu> getMenusByRestaurant(int restaurantId) {

        String sql = "SELECT * FROM Menu WHERE restaurantId = ?";
        List<Menu> menus = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, restaurantId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Menu menu = new Menu(
                        resultSet.getInt("menuId"),
                        resultSet.getInt("restaurantId"),
                        resultSet.getString("itemName"),
                        resultSet.getString("description"),
                        resultSet.getDouble("price"),
                        resultSet.getBoolean("isAvailable"),
                        resultSet.getString("imagePath")
                    );

                    menus.add(menu);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menus;
    }

    @Override
    public void updateMenu(Menu menu) {

        String sql = "UPDATE Menu SET "
                   + "restaurantId = ?, itemName = ?, description = ?, "
                   + "price = ?, isAvailable = ?, imagePath = ? "
                   + "WHERE menuId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, menu.getRestaurantId());
            statement.setString(2, menu.getItemName());
            statement.setString(3, menu.getDescription());
            statement.setDouble(4, menu.getPrice());
            statement.setBoolean(5, menu.isAvailable());
            statement.setString(6, menu.getImagePath());
            statement.setInt(7, menu.getMenuId());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int menuId) {

        String sql = "DELETE FROM Menu WHERE menuId = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, menuId);

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}