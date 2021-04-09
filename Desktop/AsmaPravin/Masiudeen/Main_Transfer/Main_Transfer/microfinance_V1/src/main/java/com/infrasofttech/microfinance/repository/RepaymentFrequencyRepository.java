package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;
import com.infrasofttech.microfinance.entityBeans.master.RepaymentFrequencyEntity;

public interface RepaymentFrequencyRepository extends JpaRepository<RepaymentFrequencyEntity, Long> {

}
