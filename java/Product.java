
public class Product {
    private int productID;
    private String name;
    private double price;
    private String category;
    private String description;
    private String imagePath;

    // Constructor
    public Product(int productID, String name, double price, String category, String description, String imagePath) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.category = category;
        this.description = description;
        this.imagePath = imagePath;
    }

    // Getters and Setters
    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    // Display method for console testing
    public void displayProduct() {
        System.out.println("ID: " + productID);
        System.out.println("Name: " + name);
        System.out.println("Price: RM" + price);
        System.out.println("Category: " + category);
        System.out.println("Description: " + description);
        System.out.println("Image: " + imagePath);
        System.out.println("---------------------------");
    }
}
