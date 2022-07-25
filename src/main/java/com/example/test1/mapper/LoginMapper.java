package com.example.test1.mapper;

import com.example.test1.domain.SecurityMember;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface LoginMapper {
    SecurityMember getSelectMemberInfo(String id);
    int setUpdatePasswordLockCnt(String id);
    int setUpdatePasswordLockCntReset(String id);
}
