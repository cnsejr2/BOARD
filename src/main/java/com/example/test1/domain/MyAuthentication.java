package com.example.test1.domain;

import lombok.Builder;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;
import java.util.List;

@Slf4j
public class MyAuthentication extends UsernamePasswordAuthenticationToken {

    private static final long serialVersionUID = 1L;
    SecurityMember member;

    public MyAuthentication(String id, String password, List<GrantedAuthority> authList, SecurityMember member) {
        super(id, password, authList);
        this.member = member;
    }

    public MyAuthentication(String id, String password, Collection<? extends GrantedAuthority> authorities) {
        super(id, password, authorities);
    }
}
