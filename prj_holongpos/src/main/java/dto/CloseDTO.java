package dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class CloseDTO {
	
	private int cashsales;
	private int cardsales;
	private int totalsales;
	private Date closedate;
	

}
