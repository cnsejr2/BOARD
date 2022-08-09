package com.example.test1.service;

import com.example.test1.domain.Comment;
import com.example.test1.domain.Criteria;
import com.example.test1.mapper.CommentMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@Transactional
public class CommentService {

    @Resource
    CommentMapper commentMapper;
    public void insertComment(Comment comment) { commentMapper.insertComment(comment); }
    public List<Comment> selectCommentList(Long id) { return commentMapper.selectCommentList(id); }
    public void deleteComment(Long id) { commentMapper.deleteComment(id); }
    public void updateComment(Map input) { commentMapper.updateComment(input); }
    public List<Comment> findCommentPagingByWriter(String writer, Criteria cri) { return commentMapper.findCommentPagingByWriter(writer, cri); }
    public int getTotalByWriter(String writer) { return  commentMapper.getTotalByWriter(writer); }
}
