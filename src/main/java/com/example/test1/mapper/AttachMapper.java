package com.example.test1.mapper;

import com.example.test1.domain.AttachImage;

import java.util.List;

public interface AttachMapper {

    /* 이미지 데이터 반환 */
    List<AttachImage> getAttachList(Long bId);
}
