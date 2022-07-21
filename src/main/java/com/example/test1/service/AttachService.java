package com.example.test1.service;

import com.example.test1.domain.AttachImage;
import com.example.test1.mapper.AttachMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Slf4j
@Service
@Transactional
public class AttachService {

    @Resource
    AttachMapper attachMapper;

    public List<AttachImage> getAttachList(Long bId) { return attachMapper.getAttachList(bId); }
}
