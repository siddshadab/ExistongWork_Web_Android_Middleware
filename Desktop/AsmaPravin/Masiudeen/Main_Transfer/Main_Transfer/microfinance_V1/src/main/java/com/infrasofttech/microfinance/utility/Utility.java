package com.infrasofttech.microfinance.utility;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collection;


public class Utility {



	public static  boolean checkIfNullOrEmpty(String value) {
		return value == null || "".equals(value.trim())?true:false;

	}
	
	public static long calculateAge(LocalDateTime fromDateTime){
		
		//LocalDateTime fromDateTime = customerEntityBean.getMdob();
		LocalDateTime toDateTime = LocalDateTime.now();
		LocalDateTime tempDateTime = LocalDateTime.from( fromDateTime );
		return  tempDateTime.until( toDateTime, ChronoUnit.YEARS);
	    
	}
	
	public static String unFormateDt(LocalDateTime d)	{
		if (d != null) {			
			if(d.getDayOfMonth()<10 && d.getMonthValue()<10){
				return String.valueOf(d.getYear()+"0"+d.getMonthValue()+"0"+d.getDayOfMonth());
			}else if(d.getDayOfMonth()<10) {
				return String.valueOf(d.getYear()+""+d.getMonthValue()+"0"+d.getDayOfMonth());
			}else if(d.getMonthValue()<10){
				return String.valueOf(d.getYear()+"0"+d.getMonthValue()+""+d.getDayOfMonth());
			}else {
				return String.valueOf(d.getYear()+""+d.getMonthValue()+""+d.getDayOfMonth());
			}		
		 }
		return "";
	}

	
	public static LocalDateTime changeToDt(String d)	{
		System.out.println("Coming Inside" + d);
		
		LocalDateTime dateTime = LocalDateTime.now();
		System.out.println( d.substring(0,4));
		System.out.println( d.substring(4,6));
		System.out.println( d.substring(6,8));
		
		System.out.println("total Date is "+  d.substring(0,4)+"-"+d.substring(4,6)+"-"+d.substring(6,8)+" 11:30:40");
		
		if(d!=null&&d.length()==8) {
			String strDt  = d.substring(0,4)+"-"+d.substring(4,6)+"-"+d.substring(6,8)+" 11:30:40" ;
			
			System.out.println("Made up date is "+strDt)
			;
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			dateTime  = LocalDateTime.parse(strDt, formatter);
			System.out.println("returning date time is " + dateTime);
			
			
		}
		
		return dateTime;
		
		
		
	}

	
	public static String chngToYN(String no) {
		
		if("1".equals(no)) {
			return "Y";
		} else {
			return "N";
		}
		
	}

/*	public static void setRadioAndCheckBoxesData(Collection<CustomerRadioCheckLinkEntity> radioCheckBox,RadioCheckBoxesDataBean dataBean) {
		// TODO Auto-generated method stub
		
		for(CustomerRadioCheckLinkEntity bean : radioCheckBox) {
			getKeyOrValue(bean,dataBean);
			System.out.println("keyDataHere is the why ok no where : "+bean.getKey1());
			System.out.println("ValueDataHere is the why ok no where : "+bean.getValue1());
		}

	}*/

/*	private static void getKeyOrValue(CustomerRadioCheckLinkEntity bean, RadioCheckBoxesDataBean dataBean) {
		if("Loan Agreed".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setLoanAgreed(bean.getKey1());
		} else if("Insurance".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setInsurance(bean.getKey1());
		} else if("Gender".equalsIgnoreCase(bean.getFieldCaption())) {
			if("0".equals(bean.getValue1())) {
				dataBean.setGender("M");
			}else {
				dataBean.setGender("F");
			}					
		} else if("Region".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setRegion(bean.getKey1());
		} else if("If Yes, Then".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setIfYesThen(bean.getKey1());
		} else if("Relegion".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setRelegion(bean.getKey1());
		} else if("Maritial Status".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setMaritialStatus(bean.getKey1());
		} else if("Qualification".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setQualification(bean.getKey1());
		} else if("Occupation".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setOccupation(bean.getKey1());
		} else if("Caste".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setCaste(bean.getKey1());
		} else if("Title".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setTitle(bean.getKey1());
		} else if("Please choose your ID:".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setId1(bean.getKey1());
		} else if("Please choose your ID 2:".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setId2(bean.getKey1());
		} else if("Construction".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setConstruction(bean.getKey1());
		} else if("Toilet".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setToilet(bean.getKey1());
		} else if("Bank Account".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setBankAccount(bean.getKey1());
		} else if("House".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setHouse(bean.getKey1());
		} else if("Agricultural Land Owner".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setAgriculturalLandOwner(bean.getKey1());
		} else if("Occupation/Business".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setOccupationOrBusiness(bean.getKey1());
		} else if("House and Business at same Place".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setHouseAndBusinessAtSamePlace(bean.getKey1());
		} else if("Registered Business".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setRegisteredBusiness(bean.getKey1());
		} else if("Business Trend".equalsIgnoreCase(bean.getFieldCaption())) {
					dataBean.setBusinessTrend(bean.getKey1());
				} 

			}*/

	
/*	public static  String getTitle(String title) {
		if("Others".equalsIgnoreCase(title)) {
			return "999";
		}else if("M/S".equalsIgnoreCase(title)) {
			return "12";
		}else if("Master".equalsIgnoreCase(title)) {
			return "MSTR";
		}else if("Md".equalsIgnoreCase(title)) {
			return "MD";
		}else if("Mr".equalsIgnoreCase(title)) {
			return "MR";
		}else if("Mrs".equalsIgnoreCase(title)) {
			return "MRS";
		}else if("Miss".equalsIgnoreCase(title)) {
			return "MS";
		}
		return null;
	}*/

	/*
	public static  String getMaratialStatus(String maratialStatus) {
		if("Single".equalsIgnoreCase(maratialStatus)) {
			return "000000001";
		}else if("Married".equalsIgnoreCase(maratialStatus)) {
			return "000000002";
		}else if("Divorced".equalsIgnoreCase(maratialStatus)) {
			return "000000003";
		}else if("Widowed".equalsIgnoreCase(maratialStatus)) {
			return "000000004";
		}
		return null;
	}

	/*
	public static  String getRelegion(String relrgion) {
		if("Muslim".equalsIgnoreCase(relrgion)) {
			return "000000001";
		}else if("Hindu".equalsIgnoreCase(relrgion)) {
			return "000000002";
		}else if("Cristain".equalsIgnoreCase(relrgion)) {
			return "000000003";
		}else if("Buddhism".equalsIgnoreCase(relrgion)) {
			return "000000004";
		}else if("Judaism".equalsIgnoreCase(relrgion)) {
			return "000000005";
		}else if("Others".equalsIgnoreCase(relrgion)) {
			return "000000006";
		}
		return null;
	}

	public static  String getEducation(String education) {
		if("litrate".equalsIgnoreCase(education)) {
			return "10";
		}else if("illitrate".equalsIgnoreCase(education)) {
			return "1";
		}else if("Matric".equalsIgnoreCase(education)) {
			return "10";
		}else if("Graduate".equalsIgnoreCase(education)) {
			return "14";
		}else if("Texhnical".equalsIgnoreCase(education)) {
			return "13";
		}else if("Others".equalsIgnoreCase(education)) {
			return "1";
		}
		return null;
	}
	
	
	public static  String getOccupation(String occupation) {
		if("Self-Employed".equalsIgnoreCase(occupation)) {
			return "000000001";
		}else if("Labour".equalsIgnoreCase(occupation)) {
			return "000000002";
		}else if("Farmer".equalsIgnoreCase(occupation)) {
			return "000000003";
		}else if("Saliried".equalsIgnoreCase(occupation)) {
			return "000000004";
		}else if("Home-Maker".equalsIgnoreCase(occupation)) {
			return "000000004";
		}
		return null;
	}*/



	  public static String[] split(String str, char delimiter)
	  {
		   if (isNull(str))
		   {
			   return null;
		   }
		   else if(str.indexOf(delimiter)==-1)
		   {
			   String [] singleString = new String[]{str};
			   return singleString;			   
		   }
		   else
		   {   
			   String strArray[] = null;
			   int startIndex = 0;
			   ArrayList arList = new ArrayList();
			   int count = 0;
			   int strLen = str.length();
			   if (str.charAt((strLen-1)>=0?(strLen-1):0)== delimiter)
			   {
				   strLen++;
			   }
			   for (startIndex=0;startIndex<strLen;startIndex++)
			   {
				   int endIndex = str.indexOf(delimiter,startIndex);
				   if (endIndex == -1)
				   {
					   endIndex = strLen;
				   }
				   
				   String val = "";
				   try
				   {
					   val = str.substring(startIndex,endIndex);
				   }
				   catch(StringIndexOutOfBoundsException ste)
				   {
				   }
				   arList.add(count,val);
				   count++;
				   startIndex = endIndex;
			   }
			   int size = arList.size();
			   strArray = new String[size];
			   for(int i=0;i<size;i++)
			   {
				   strArray[i] = (String)arList.get(i);
			   }
			   return strArray;
		   }
	   }
	  
	  public static boolean isNull(String str)
	  {
	      return (str == null || str.equals("") ||  str.equals("null"));
	  }
	  
	  
	  
		public static String removeZero(String str) 
	    { 
	        // Count leading zeros 
	        int i = 0; 
	        while (i < str.length() && str.charAt(i) == '0') 
	            i++; 
	  
	        // Convert str into StringBuffer as Strings 
	        // are immutable. 
	        StringBuffer sb = new StringBuffer(str); 
	  
	        // The  StringBuffer replace function removes 
	        // i characters from given index (0 here) 
	        sb.replace(0, i, ""); 
	  
	        return sb.toString();  // return in String 
	    } 
		


}