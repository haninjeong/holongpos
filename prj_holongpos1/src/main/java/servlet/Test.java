package servlet;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import dbcon.MenuDAO;
import dbcon.OrderMenuDAO;
import dto.MenuDTO;
import dto.OrderMenuDTO;

public class Test {

	public static void main(String[] args) {
		
		int payment=7004;
		OrderMenuDAO dao=new OrderMenuDAO();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yy/MM/dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm:ss");
		List<OrderMenuDTO> paymentSearchList=dao.receiptSearchList(payment);
		JSONArray  jList =new JSONArray();
		JSONObject obj2 = new JSONObject();
		Map<String, Object> maplist= new HashMap<String, Object>();
		
		for(int i=0;i<paymentSearchList.size();i++) {
			
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("receipt_no", paymentSearchList.get(i).getReceipt_no());
			map.put("pay_date",sdf1.format( paymentSearchList.get(i).getPay_date()));
			map.put("pay_date2",sdf2.format( paymentSearchList.get(i).getPay_date()));
			map.put("totalprice", paymentSearchList.get(i).getTotalprice());
			map.put("payment", paymentSearchList.get(i).getPayment());
			jList.put(map);
			
			
		}
		obj2.put("receiptList", jList);
		maplist.put("receiptList", jList);
		System.out.println(maplist.toString());
		
	}

}
