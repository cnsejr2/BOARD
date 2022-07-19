package com.example.test1.mapper;

import com.example.test1.domain.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface CommentMapper {
    void insertComment(Comment comment);

    List<Comment> selectCommentList(Long id);

    void deleteComment(Long id);

    void updateComment(Map input);
}
