package com.example.test1.mapper;

import com.example.test1.domain.SecurityMember;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface AdminMapper {

    List<SecurityMember> findMemberList();

    SecurityMember findMember(String id);

    void deleteMember(String id);
}
