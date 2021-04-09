package com.infrasofttech.microfinance.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.infrasofttech.microfinance.entityBeans.master.LoanUtilizationEntity;

public interface LoanUtilizationRepository extends JpaRepository<LoanUtilizationEntity, Long> {


}
