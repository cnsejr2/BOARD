package com.example.test1.mapper;

import com.example.test1.domain.ItemImage;
import com.example.test1.domain.ReviewFile;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
@Mapper
public interface ReviewFileMapper {
    List<ReviewFile> getReviewFile(Long fileId);
    List<ReviewFile> findAllReviewFile();
    void deleteReviewFile(Long fileId);
    void fileReEnroll(ReviewFile reviewFile);
    void deleteReviewFileAll(Long fileId);
    List<ReviewFile> checkFileList();
}
