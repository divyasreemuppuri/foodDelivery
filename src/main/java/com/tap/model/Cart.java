package com.tap.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {

    private int restaurantId;
    private Map<Integer, CartItem> items;

    public Cart() {
        items = new LinkedHashMap<>();
    }

    public Cart(int restaurantId) {
        this.restaurantId = restaurantId;
        items = new LinkedHashMap<>();
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void setItems(Map<Integer, CartItem> items) {
        this.items = items;
    }

    public void addItem(CartItem cartItem) {

        int menuId = cartItem.getMenu().getMenuId();

        if (items.containsKey(menuId)) {

            CartItem existingItem = items.get(menuId);

            existingItem.setQuantity(
                existingItem.getQuantity() + cartItem.getQuantity()
            );

        } else {

            items.put(menuId, cartItem);
        }
    }

    public void removeItem(int menuId) {

        items.remove(menuId);
    }

    public double getTotalAmount() {

        double total = 0;

        for (CartItem cartItem : items.values()) {

            total += cartItem.getTotalPrice();
        }

        return total;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "restaurantId=" + restaurantId +
                ", items=" + items +
                ", totalAmount=" + getTotalAmount() +
                '}';
    }
}