package com.infrasofttech.microfinance.entityBeans.master;



import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Entity
@Table(name = "CustomerPaymentMethodDetailsEntity", indexes = { @Index(columnList = "mrefno", name = "CustomerPaymentMethodDetailsEntityAltKey1")})
@Data
public class CustomerPaymentMethodDetailsEntity implements Serializable {

    private static final long serialVersionUID = 1L;

	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(unique = true, nullable = false)
	private Long id; 
	
	 @Column
     private String paymentMode;
	  @Column
     private String bankCode;
	  @Column
     private String bankName;
	  @Column
     private String branchCode;
	  @Column
     private String branchName;
	  @Column
     private String accountNumber;
	   @Column
     private String accountType;
	   @Column
     private String ifscCode;
	   @Column
     private String accountHolderName;

     
		@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	 	@JoinColumns({
	 		  @JoinColumn(name = "mrefno"),	 		  
	 		})
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
	private CustomerEntity  paymetMethodDetailsCustomerEntity;
	
}
