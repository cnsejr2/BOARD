package com.example.test1.domain;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;

//import javax.persistence.*;
import java.util.*;
@Slf4j
@Getter
@Setter
public class SecurityMember  implements UserDetails {
    private static final long serialVersionUID = 1L;

    private String id;

    private String password;

    private String memberName;

    private String email;

    private String userRole;

    private int passwordLock;

    private String regDate;

    private String modDate;

    private String passwordChgDate;

    private String status;

    @Builder
    public SecurityMember(String id, String password, String email, String memberName, String userRole) {
        this.id = id;
        this.password = password;
        this.email = email;
        this.memberName = memberName;
        this.userRole = userRole;
    }

    public SecurityMember() {

    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> roles = new ArrayList<>();
        roles.add(new SimpleGrantedAuthority(userRole));
        return roles;
    }

    
    public String getUserName() {
        return id;
    }
    
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return id;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }


}
