package com.example.test1.service;

import com.example.test1.domain.SecurityMember;
import com.example.test1.mapper.JoinMapper;
import com.example.test1.mapper.LoginMapper;
import com.example.test1.mapper.SecurityMemberMapper;
import com.example.test1.util.SHA_256;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Arrays;

@Service
@Slf4j
@Transactional
public class SecurityService implements UserDetailsService {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    LoginMapper loginMapper;
    @Resource
    JoinMapper joinMapper;
    @Resource
    SecurityMemberMapper securityMemberMapper;
    @Resource
    SHA_256 sha_256;
    public SecurityMember getSelectMemberInfo(String id) {
        return loginMapper.getSelectMemberInfo(id);
    }
    public void setInsertMember(SecurityMember member) {
        String pw = sha_256.encrypt(member.getPassword());
        SecurityMember sMember = SecurityMember.builder()
                .id(member.getId())
                .password("{sha256}" + pw)
                .memberName(member.getMemberName())
                .userRole(member.getUserRole())
                .email(member.getEmail())
                .build();
        joinMapper.setInsertMember(sMember);
    }

    public int setUpdatePasswordLockCnt(String id) {
        return loginMapper.setUpdatePasswordLockCnt(id);
    }

    public int setUpdatePasswordLockCntReset(String id) {
        return loginMapper.setUpdatePasswordLockCntReset(id);
    }

    public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
        SecurityMember m = securityMemberMapper.findSecurityMember(id);
        logger.info("loadUserByUsername");
        if (m != null) {
            return new org.springframework.security.core.userdetails.User(m.getUserName(), m.getPassword(),
                    Arrays.asList(new SimpleGrantedAuthority(m.getUserRole())));
        } else {
            throw new UsernameNotFoundException(id);
        }
    }
    public int idCheck (String id) throws Exception {
        return securityMemberMapper.idCheck(id);
    }

}
