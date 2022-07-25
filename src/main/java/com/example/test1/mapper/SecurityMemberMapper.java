package com.example.test1.mapper;

import com.example.test1.domain.SecurityMember;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface SecurityMemberMapper {
    public SecurityMember findSecurityMember(String username);
    public int idCheck(String id);
}
