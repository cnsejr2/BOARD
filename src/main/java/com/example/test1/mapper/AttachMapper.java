package com.example.test1.mapper;

import com.example.test1.domain.AttachImage;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
@Mapper
public interface AttachMapper {

    List<AttachImage> getAttachList(Long bId);
    void deleteImage(Long bId);
    void imageReEnroll(AttachImage attachImage);
    void deleteImageAll(Long bId);
    List<AttachImage> checkFileList();
}
