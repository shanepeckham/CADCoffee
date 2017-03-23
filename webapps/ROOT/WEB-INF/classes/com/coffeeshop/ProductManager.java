package com.coffeeshop;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.*;
import org.hibernate.cfg.*;

public class ProductManager  {

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
	
	public void addProduct(Product product) throws Exception
	{
		Session s = null;
		try{
			s =getSession();
			Transaction tx= s.beginTransaction();

			s.save(product);
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

	public ArrayList<Product> getProducts() {
		ArrayList<Product> products = new ArrayList<Product>();

		Session s = null;
		try {
			s = getSession();
			Query q = s.createQuery("FROM Product");
			List<Product> list = q.list();
			for(Product product : list)
			{
				products.add(product);
			}
		} catch (Exception e) {
			if (s != null) {
				s.disconnect();
			}
			e.printStackTrace();
		}

		return products;
	}

	public Product getProduct(int id)
	{
		Session s = null;
		try {
			s = getSession();
			Query q = s.createQuery("FROM Product where id="+id);
			List<Product> list = q.list();
			for(Product product : list)
			{
				return product;
			}
		} catch (Exception e) {
			if (s != null) {
				s.disconnect();
			}
			e.printStackTrace();
		}
		return null;
	}


}//end of class