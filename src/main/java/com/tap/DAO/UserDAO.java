
package com.tap.DAO;

import com.tap.model.User;
import java.util.List;

public interface UserDAO {

    void addUser(User user);

    User getUser(int userId);

    User getUserByEmail(String email);

    List<User> getAllUsers();

    void updateUser(User user);

    // Update only the user's profile information
    void updateProfile(User user);

    void deleteUser(int userId);
}
