package com.product.search;

import java.util.Arrays;
import java.util.Comparator;

public class ProductSearch {

    // Linear Search by productName
    public static Product linearSearch(Product[] products, String name) {
        for (Product product : products) {
            if (product.productName.equalsIgnoreCase(name)) {
                return product;
            }
        }
        return null;
    }

    // Binary Search by productId
    public static Product binarySearch(Product[] products, int targetId) {
        int low = 0, high = products.length - 1;

        while (low <= high) {
            int mid = (low + high) / 2;
            if (products[mid].productId == targetId) {
                return products[mid];
            } else if (products[mid].productId < targetId) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return null;
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product(103, "Laptop", "Electronics"),
            new Product(101, "Pen", "Stationery"),
            new Product(105, "Shoes", "Footwear"),
            new Product(102, "Book", "Stationery"),
            new Product(104, "Phone", "Electronics")
        };

        // Linear Search
        Product foundByName = linearSearch(products, "Book");
        System.out.println("Linear Search Result: " + (foundByName != null ? foundByName : "Product not found"));

        // Sort for Binary Search
        Arrays.sort(products, Comparator.comparingInt(p -> p.productId));

        // Binary Search
        Product foundById = binarySearch(products, 104);
        System.out.println("Binary Search Result: " + (foundById != null ? foundById : "Product not found"));
    }
}
