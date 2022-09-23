package com.study.springboot.jdbc;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IOrderMenuDAO {
	
	public int insertOrderMenu(String menus,String menus_price,String menus_no,String menus_totalprice,
			long totalno,String totalprice,String payment);
	public List<OrderMenuDTO> orderList (long receiptnum);
	public List<OrderMenuDTO> receiptList (long pagenum ,long amount);
	public int updateOrderMenu(long receipt_no );
	public int totalOrderMenu();
	public List<OrderMenuDTO>paymentSearchList(String payment);
	public List<OrderMenuDTO>receiptSearchList(long receipt);
	public List<OrderMenuDTO> totalpriceList(long startDate,long lastDate);
	public List<OrderMenuDTO> closecash(long date);
	public List<OrderMenuDTO> closecard(long date);
	
	
	
	

}
