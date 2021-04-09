package com.infrasofttech.microfinance.configurations;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;


@Configuration
@Order(Ordered.HIGHEST_PRECEDENCE)
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class CustomWebSecurityConfigurer
  extends WebSecurityConfigurerAdapter  {
 
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.addFilterAfter(
          new CustomURLFilter(), BasicAuthenticationFilter.class);
    }
}
