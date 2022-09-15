package dto;



import java.sql.Date;

import lombok.Data;
@Data
public class OrderMenuDTO {
	
	private int no;
	private String menus;
	private String menus_price;
	private String menus_no;
	private String menus_totalprice;
	private int totalno;
	private int totalprice;
	private String payment;
	private Date Pay_date;
	private Date Pay_date1;
	private int receipt_no;


}
