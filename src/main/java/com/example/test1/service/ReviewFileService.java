package com.example.test1.service;

import com.example.test1.domain.ReviewFile;
import com.example.test1.mapper.ReviewFileMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Transactional
@Service
public class ReviewFileService {

    @Resource
    ReviewFileMapper reviewFileMapper;
    public List<ReviewFile> getReviewFile(Long fileId) { return reviewFileMapper.getReviewFile(fileId); }
    public List<ReviewFile> findAllReviewFile() { return reviewFileMapper.findAllReviewFile(); }
    public void deleteReviewFile(Long fileId) { reviewFileMapper.deleteReviewFile(fileId); }
    public void fileReEnroll(ReviewFile reviewFile) { reviewFileMapper.fileReEnroll(reviewFile); }
    public void deleteReviewFileAll(Long fileId) { reviewFileMapper.deleteReviewFileAll(fileId); }
    public List<ReviewFile> checkFileList() { return reviewFileMapper.checkFileList(); }
}
