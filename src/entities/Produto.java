package entities;

public class Produto {
    public String name;
    public double price;
    public int quantity;

    public double TotalValueInStock() {
        return this.price * this.quantity;
    }

    public void AddProducts(int quantity) {
        this.quantity += quantity;
        System.out.printf("Updated data: %s, $ %.2f, %d units, Total: $ %.2f", this.name, this.price, this.quantity, this.TotalValueInStock());
    }

    public void RemoveProducts(int quantity) {
        this.quantity -= quantity;
        System.out.printf("Updated data: %s, $ %.2f, %d units, Total: $ %.2f", this.name, this.price, this.quantity, this.TotalValueInStock());
    }

}
