package com.infrasofttech.microfinance.entityBeans.master;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import lombok.Data;

@Entity
@Table(name = "md009097")
@Data
public class CustomerProductwiseCycleEntity extends BaseEntity {

	@EmbeddedId
	private CustomerProductwiseCycleCompositeEntity customerProductwiseCycleCompositeEntity;

    @Column(name = "mcycle", columnDefinition = "numeric(8) default 0")
	private int mcycle;  
  

}
