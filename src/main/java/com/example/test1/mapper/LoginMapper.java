package com.example.test1.mapper;

import com.example.test1.domain.SecurityMember;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface LoginMapper {
    // 회원정보조회
    SecurityMember getSelectMemberInfo(String id);

    // 비밀번호 틀린 횟수 증가
    int setUpdatePasswordLockCnt(String id);
    // 비밀번호 틀린 횟수 초기화
    int setUpdatePasswordLockCntReset(String id);
}
