package com.coffeeshop;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.io.*;

import org.hibernate.*;
import org.hibernate.cfg.*;

public class OrderManager  {

	private static  SessionFactory sessionFactory;
	  private Session getSession()  throws Exception
	  {
	  Session s =null;
	     try{
		 		sessionFactory = new Configuration().configure("com\\xmlFiles\\hibernate.cfg.xml").buildSessionFactory();
		 		s=sessionFactory.openSession();
	 		}catch(HibernateException e){
					throw e;
		   }
		   return s;
	  }
	public  void addOrder(Order order) throws Exception
	 {
		Session s = null;
	   try{
	 		s =getSession();
	 		Transaction tx= s.beginTransaction();
	 		s.save(order);
	 		tx.commit();
	 		s.flush();
	 		s.disconnect();
	   }
	   catch(HibernateException e)
	   {
		   if(s != null)
		   {
			   s.disconnect();
		   }
		   throw e;
	   }
	}
}//end of class