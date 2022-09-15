package dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CloseshopDTO {
	
	
	private int cashsales ;
	private int cardsales ;
	private int totalsales ;
	private Date closedate ;

}
