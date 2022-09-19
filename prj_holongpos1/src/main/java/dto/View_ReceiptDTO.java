package dto;

import java.sql.Date;

import lombok.Data;
@Data
public class View_ReceiptDTO {
	private int id;
	private String value;
	private String price;
	private String ea;
	private String totalprice;
	private Date reg_date;
	private int receiptnum;

}
