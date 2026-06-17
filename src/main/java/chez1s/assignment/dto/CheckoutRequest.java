package chez1s.assignment.dto;

import lombok.Data;
import java.util.List;

@Data
public class CheckoutRequest {
    private String guestName;
    private String guestPhone;
    private Integer tableId;
    private String paymentMethod;
    private Integer guestVoucherId;
    private List<CartItem> items;

    @Data
    public static class CartItem {
        private Integer drinkId;
        private Integer quantity;
        private String note;
    }
}
