package application;

import java.util.Scanner;
import java.util.Locale;

import entities.Produto;

public class Estoque {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        Locale.setDefault(Locale.US);


        Produto p1 = new Produto();
        System.out.println("Enter product data: ");
        System.out.println("Name: ");
        p1.name = input.next();
        System.out.println("Price: ");
        p1.price = input.nextDouble();
        System.out.println("Quantity: ");
        p1.quantity = input.nextInt();

        System.out.printf("Product data: %s, $ %.2f, %d units, Total: $ %.2f\n", p1.name, p1.price, p1.quantity, p1.TotalValueInStock());

        System.out.println("Adicionar estoque: 1\nRemover estoque: 2\nSair da tela: 3");
        int escolha = input.nextInt();

        if (escolha == 1) {
            System.out.println("Quantity: ");
            p1.quantity = input.nextInt();
            p1.RemoveProducts(p1.quantity);
        } else if (escolha == 2) {
            System.out.println("Quantity: ");
            p1.quantity = input.nextInt();
            p1.RemoveProducts(p1.quantity);
        } else {
            System.exit(0);
        }

        input.close();
    }
}
