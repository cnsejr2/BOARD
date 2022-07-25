package com.example.test1.service;

import com.example.test1.domain.AttachImage;
import com.example.test1.mapper.AttachMapper;
import lombok.extern.slf4j.Slf4j;
import org.omg.CORBA.PUBLIC_MEMBER;
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
    public void imageReEnroll(AttachImage attachImage) { attachMapper.imageReEnroll(attachImage); }
    public void deleteImage(Long bId) { attachMapper.deleteImage(bId); }
    public void deleteImageAll(Long bId) { attachMapper.deleteImageAll(bId); }
    public List<AttachImage> checkFileList() { return attachMapper.checkFileList(); }
}
