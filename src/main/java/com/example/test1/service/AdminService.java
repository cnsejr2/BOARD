package com.example.test1.service;

import com.example.test1.domain.OrderList;
import com.example.test1.domain.SecurityMember;
import com.example.test1.mapper.AdminMapper;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Slf4j
@Service
@Transactional
public class AdminService {

    @Resource
    AdminMapper adminMapper;

    public List<SecurityMember> findMemberList() {
        return adminMapper.findMemberList();
    }
    public SecurityMember findMember(String id) { return adminMapper.findMember(id); }
    public void deleteMember(String id) { adminMapper.deleteMember(id); }
    public List<OrderList> selectOrderList() { return adminMapper.selectOrderList(); }

}
