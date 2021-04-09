package com.infrasofttech.microfinance.entityBeans.master.base;

import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;

import lombok.Data;

@MappedSuperclass
@Data
public class BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;
    

    public BaseEntity() {
        super();
    }

/*    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    @CreatedDate
    private Date createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_at")
    @LastModifiedDate
    private Date updatedAt;
    
    @Column  
	  private String createdBy;
	  @Column  
	  private String updatedBy;
	  */
	  
	     @Column(name = "mcreateddt")  	  
		 private LocalDateTime mcreateddt;
		 @Column(name = "mcreatedby", columnDefinition = "NVarChar(10)")
		 private String mcreatedby;
		 @Column(name = "mlastupdatedt") 
		 
		 private LocalDateTime mlastupdatedt;	
		 @Column(name = "mlastupdateby",  columnDefinition = "NVarChar(10)")
		 private String mlastupdateby;
		 @Column(name = "mgeolocation",  columnDefinition = "NVarChar(250)")
		 private String mgeolocation;
		 @Column(name = "mgeolatd",  columnDefinition = "NVarChar(20)")
		 private String mgeolatd;
		 @Column(name = "mgeologd",  columnDefinition = "NVarChar(20)")
		 private String mgeologd;
		 @Column(name = "missynctocoresys",  columnDefinition = "numeric(1) default 0")
		 private int missynctocoresys;
		 @Column(name = "mlastsynsdate"  )		 
		 private LocalDateTime mlastsynsdate ;
	  
    
    
}
