package com.example.test1.mapper;

import com.example.test1.domain.AttachImage;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
@Mapper
public interface AttachMapper {

    /* 이미지 데이터 반환 */
    List<AttachImage> getAttachList(Long bId);
}
