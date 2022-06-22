package entities;

public class Produto {
    public String name;
    public double price;
    public int quantity;

    public double TotalValueInStock() {
        return this.price * this.quantity;
    }

    public void AddProducts(int quantity) {
        this.quantity = this.quantity + quantity;
        //System.out.printf("Updated data: %s, $ %.2f, %d units, Total: $ %.2f", this.name, this.price, this.quantity, this.TotalValueInStock());
    }

    public void RemoveProducts(int quantity) {
        this.quantity = this.quantity - quantity;
        //System.out.printf("Updated data: %s, $ %.2f, %d units, Total: $ %.2f", this.name, this.price, this.quantity, this.TotalValueInStock());
    }

    public String toString() {
        return this.name + ", $ " + this.price + ", " + this.quantity + " units, Total: $ " + this.TotalValueInStock();
    }

//    public String UpdateData() {
//        return "Updated data: " + this.name + ", $ " + String.format("%.2f", this.price) + ", " + this.quantity
//                + "units, Total: $ " + String.format("%.2f",this.TotalValueInStock());
//    }

}
