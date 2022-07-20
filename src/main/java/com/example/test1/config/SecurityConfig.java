package com.example.test1.config;

import com.example.test1.security.*;
import com.example.test1.service.SecurityService;
import com.example.test1.util.SHA_256;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.DelegatingPasswordEncoder;
import org.springframework.security.crypto.password.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;

@Configuration
@EnableWebSecurity
@Slf4j
public class SecurityConfig {

    @Resource
    SecurityService securityService;
    @Resource
    MyAccessDeniedHandler myAccessDeniedHandler;
    @Resource
    MyLoginFailureHandler myLoginFailureHandler;
    @Resource
    MyLoginSuccessHandler myLoginSuccessHandler;
    @Resource
    MyLogoutSuccessHandler myLogoutSuccessHandler;
    @Resource
    SHA_256 sha_256;

    private final DataSource dataSource;

    public SecurityConfig(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
                .csrf()
                    .disable()
                    .authorizeRequests()
                        .antMatchers("/css/**").permitAll()
                        .antMatchers("/security/login/**", "/resources/css/**")
                            .permitAll()
                        .antMatchers("/admin/board/list").hasAuthority("ROLE_ADMIN")
                        .anyRequest()
                        .authenticated()
                .and()
                .formLogin()
                    .loginPage("/security/login")
                    .loginProcessingUrl("/doLogin")
                    .usernameParameter("username")
                    .passwordParameter("pw")
                    .successHandler(myLoginSuccessHandler)
                    .failureHandler(myLoginFailureHandler)
                    .and()
                .logout()
                    .logoutUrl("/doLogout")
                    .logoutSuccessUrl("/security/login")
                        .logoutSuccessHandler(myLogoutSuccessHandler)
                    .invalidateHttpSession(true)
                    .deleteCookies("remember-me", "JSESSIONID")
                .and()
                .rememberMe()
                    .rememberMeParameter("remember")
                    .tokenValiditySeconds(604800) // 일주일
                    .userDetailsService(securityService)
                    .tokenRepository(tokenRepository())
                .and()
                .exceptionHandling()
                .authenticationEntryPoint(myAuthenticationEntryPoint())
                .accessDeniedHandler(myAccessDeniedHandler);

        return http.build();
    }
//    @Bean
//    public PasswordEncoder passwordEncoder() {
//        Map<String, PasswordEncoder> encoders = new HashMap<>();
//        encoders.put("bcrypt", new BCryptPasswordEncoder());
//        encoders.put("sha256", sha_256);
//
//        return new DelegatingPasswordEncoder(
//                "sha256", encoders);
//    }
//
//    @Bean
//    public DaoAuthenticationProvider authenticationProvider() {
//        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
//        authenticationProvider.setUserDetailsService(securityService);
//        authenticationProvider.setPasswordEncoder(passwordEncoder());
//        return authenticationProvider;
//    }


    @Bean(name = "persistentTokenRepository")
    public PersistentTokenRepository tokenRepository() {
        JdbcTokenRepositoryImpl jdbcTokenRepository = new JdbcTokenRepositoryImpl();
        jdbcTokenRepository.setDataSource(dataSource);
        return jdbcTokenRepository;
    }

    @Bean
    public MyAuthenticationEntryPoint myAuthenticationEntryPoint() {
        return new MyAuthenticationEntryPoint("/security/login");
    }
}
