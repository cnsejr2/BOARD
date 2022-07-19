package com.example.test1.mapper;

import com.example.test1.domain.Board;
import com.example.test1.domain.Comment;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface BoardMapper {

    void viewCntBoard(Board board);
    void insertBoard(Board board);

    Board selectBoardDetail(Long id);

    int updateBoard(Board board);

    void deleteBoard(Long id);

    int selectBoardTotalCount();

    List<Board> findAll();

    List<Board> findByWriter(String writer);

    List<Board> selectBoardSearchList(String keyword, String sort);



}
