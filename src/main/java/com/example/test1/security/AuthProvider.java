package com.example.test1.security;

import com.example.test1.domain.MyAuthentication;
import com.example.test1.domain.SecurityMember;
import com.example.test1.service.SecurityService;
import com.example.test1.util.SHA_256;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
@Slf4j
@Service
public class AuthProvider implements AuthenticationProvider {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    SecurityService securityService;
    @Resource
    SHA_256 sha_256;
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String id = authentication.getName();
        String password = authentication.getCredentials().toString();
        return authentication(id, password);
    }

    private Authentication authentication(String id, String password) {
//        List<GrantedAuthority> grantedAuthorityList = new ArrayList<GrantedAuthority>();
        UserDetails sMember = securityService.loadUserByUsername(id);
        String pw = "{sha256}" + sha_256.encrypt(password);
        if (sMember == null) {
            logger.info("No info");
            throw new UsernameNotFoundException("사용자 정보 없음");
        } else if (sMember != null && !sMember.getPassword().equals(pw)) {
            logger.info("Error Password");
            throw new BadCredentialsException("비밀번호 틀림");
        }
//        grantedAuthorityList.add(new SimpleGrantedAuthority(sMember.getAuthorities()));

        return new MyAuthentication(id, password, sMember.getAuthorities());
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}
