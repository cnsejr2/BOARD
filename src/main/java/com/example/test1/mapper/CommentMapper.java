package com.example.test1.mapper;

import com.example.test1.domain.Comment;
import com.example.test1.domain.Criteria;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
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
    List<Comment> findCommentPagingByWriter(@Param("writer") String writer, Criteria cri);
    int getTotalCommentByWriter(@Param("writer") String writer);

}
