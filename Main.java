public class Main {
    public static void main(String[] args) {
        Admin admin = new Admin();

        // Test manually (simulate GUI submission)
        admin.addProduct("Chocolate Cake", 25.0, "Cake", "Rich cake", "chocolate.png");
        admin.addProduct("Red Velvet", 30.0, "Cake", "Soft velvet", "redvelvet.png");

        // View products
        admin.viewProducts();
    }
}
