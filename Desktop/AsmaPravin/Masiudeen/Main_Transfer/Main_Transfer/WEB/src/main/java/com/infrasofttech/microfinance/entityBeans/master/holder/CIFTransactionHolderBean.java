package com.infrasofttech.microfinance.entityBeans.master.holder;


import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;

import com.infrasofttech.microfinance.entityBeans.master.CustomerAddressDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerAssetDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerHouseholdExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPPIDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPaymentMethodDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Data
public class CIFTransactionHolderBean extends BaseEntity {	
	
	private int mcustno;
	private String mnid;
	private int mlbrcode;
	private String mprdacctid;	
	private int mmoduletype;
	private int macctstat;
	private String mcrdr;
	private String mremark;
	private double mamt;
	private String momnitxnrefno;
	private String merror;
	private String mcreatedby;
	private String mnarration;
	private String misbiometricdeclareflagyn;

}
