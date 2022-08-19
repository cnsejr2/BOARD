package com.example.test1.service;

import com.example.test1.domain.OrderList;
import com.example.test1.domain.SecurityMember;
import com.example.test1.mapper.MemberMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
@Slf4j
@Service
@Transactional
public class MemberService {
    @Resource
    MemberMapper memberMapper;

    public SecurityMember findMember(String id) { return memberMapper.findMember(id); }
    public List<OrderList> selectOrderList(String id) { return memberMapper.selectOrderList(id); }
}
