package com.example.test1.mapper;

import com.example.test1.domain.SecurityMember;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface JoinMapper {
    // 회원가입
    void setInsertMember(SecurityMember member);
}
