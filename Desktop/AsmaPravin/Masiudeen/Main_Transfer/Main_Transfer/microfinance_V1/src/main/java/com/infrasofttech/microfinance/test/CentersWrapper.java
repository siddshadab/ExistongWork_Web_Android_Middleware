package com.infrasofttech.microfinance.test;

import java.util.Iterator;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;

public class CentersWrapper {
	
	List<CentersFoundationEntity> centerList;
	
	/*public static void main(String[] args) {
		String st = "[{\"countryID\":69,\"countryName\":\"India\",\"states\":[{\"statesID\":70,\"statesName\":\"Maharashtra\",\"districts\":[{\"districtsID\":75,\"districtsName\":\"mumbai\"},{\"districtsID\":76,\"districtsName\":\"thane\"},{\"districtsID\":77,\"districtsName\":\"raigadh\"}]},{\"statesID\":71,\"statesName\":\"rajashtan\",\"districts\":[{\"districtsID\":78,\"districtsName\":\"falna\"},{\"districtsID\":79,\"districtsName\":\"jaipur\"}]},{\"statesID\":72,\"statesName\":\"gujrat\",\"districts\":[{\"districtsID\":80,\"districtsName\":\"surat\"},{\"districtsID\":81,\"districtsName\":\"valsad\"}]},{\"statesID\":73,\"statesName\":\"uttranchal\",\"districts\":[]},{\"statesID\":74,\"statesName\":\"madyapradesh\",\"districts\":[]}]}]\r\n";
		
		JSONArray jsonArray = new JSONArray(st);
		 JSONObject jsonObj = null;
		   for (int i = 0; i < jsonArray.length(); i++) {
			   jsonObj = jsonArray.getJSONObject(i);
			   JSONArray objArray= (JSONArray) jsonObj.getJSONArray("states");
			   for(int k = 0;k<objArray.length();k++) {
				   JSONObject jsonArryObj = objArray.getJSONObject(k);
				   
				   JSONArray objArraydist= (JSONArray) jsonArryObj.getJSONArray("districts");
				   for(int m = 0;m<objArray.length();m++) {
					   JSONObject jsonArryObjDist = objArray.getJSONObject(m);
					   for(String str: jsonArryObjDist.keySet()) {
		    			   System.out.println("Key sets dist:- "+ str);
		    		   }
				   }
				   for(String str: jsonArryObj.keySet()) {
	    			   System.out.println("Key sets :- "+ str);
	    		   } 
			   }
               System.out.println("Data aaagya yaha bhaiyaji : -"+jsonArray.get(i)+"  yaha se names hai bjaiya : -"+jsonObj.names()+" keys yaha hai :- "+jsonObj.keys());
               for(String str: jsonObj.keySet()) {
    			   System.out.println("Key sets :- "+ str);
    		   }
    		
		   }
		
		   
		  
		   
		   JSONArray jArray = new JSONArray(st);       
		   for (int i = 0; i < jArray.length(); i++) {
		        JSONObject object = jArray.optJSONObject(i);
		        Iterator<String> iterator = object.keys();
		        while(iterator.hasNext()) {
		          String currentKey = iterator.next();
		          System.out.println("Data :- "+ currentKey);
		        }
		   }
    		    

	}
	
	public static void main(String...strings) {
		getListUseFulKeys("id,centerName,branch");
		
	}
	
	 private static Object[] getListUseFulKeys(String key	){
	        Object[] valueToReturn=null;
	        //List tempList = new ArrayList();
	      //  String keys = getProperty(keyForWhom,context);
	        StringTokenizer tokenizer = new StringTokenizer(key,",");
	        while (tokenizer.hasMoreTokens()) {
	           // tempList.add(tokenizer.nextElement());
	           System.out.println("Tokenizers here "+tokenizer.nextToken());
	           //System.out.println("Tokonizer :- "+tokenizer.nextElement());
	        }
	        valueToReturn= new Object[tempList.size()];
	        valueToReturn=tempList.toArray();
	        return valueToReturn;
	    }*/

}
