import java.util.ArrayList;

public class Admin {
    private ArrayList<Product> products;
    private int nextProductID; 

    public Admin() {
        products = new ArrayList<>();
        nextProductID = 1; 
    }

    // ===== Add Product - GUI / parameterized version =====
    public void addProduct(String name, double price, String category, String description, String imagePath) {
        Product newProduct = new Product(
            nextProductID,
            name,
            price,
            category,
            description,
            imagePath
        );

        products.add(newProduct);
        nextProductID++;

        System.out.println("✅ Product added successfully: " + name);
    }
    
    /*public void addProduct() {
        System.out.println("=== Add New Product ===");

        System.out.print("Enter product name: ");
        String name = sc.nextLine();

        System.out.print("Enter price: ");
        double price = sc.nextDouble();
        sc.nextLine(); // clear buffer

        System.out.print("Enter category (Cake / Pastry): ");
        String category = sc.nextLine();

        System.out.print("Enter description: ");
        String description = sc.nextLine();

        System.out.print("Enter image path: ");
        String imagePath = sc.nextLine();

        Product newProduct = new Product(
            nextProductID,
            name,
            price,
            category,
            description,
            imagePath
        );

        products.add(newProduct);
        nextProductID++;

        System.out.println("✅ Product added successfully!");
    }*/

    // ===== Edit Product (GUI-friendly version) =====
    public boolean editProduct(int id, String name, double price, String category, String description, String imagePath) {
        for (Product p : products) {
            if (p.getProductID() == id) {
                p.setName(name);
                p.setPrice(price);
                p.setCategory(category);
                p.setDescription(description);
                p.setImagePath(imagePath);
                System.out.println("✅ Product updated successfully: " + name);
                return true;
            }
        }
        System.out.println("Product ID not found!");
        return false;
    }

    // ===== Delete Product =====
    public boolean deleteProduct(int id) {
        for (Product p : products) {
            if (p.getProductID() == id) {
                products.remove(p);
                System.out.println("✅ Product deleted successfully: " + p.getName());
                return true;
            }
        }
        System.out.println("Product ID not found!");
        return false;
    }

    // ===== View Products =====
    public void viewProducts() {
        if (products.isEmpty()) {
            System.out.println("No products available.");
            return;
        }

        for (Product p : products) {
            p.displayProduct();
        }
    }

    // ===== Getters for GUI (optional) =====
    public ArrayList<Product> getProducts() {
        return products;
    }
}