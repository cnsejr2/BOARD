package com.example.test1.mapper;

import com.example.test1.domain.Board;
import com.example.test1.domain.Comment;
import com.example.test1.domain.Criteria;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface BoardMapper {

    void viewCntBoard(Board board);
    void insertBoard(Board board);

    Board selectBoardDetail(Long id);

    int updateBoard(Board board);

    void deleteBoard(Long id);

    int boardListCnt();

    List<Board> findAll();

    List<Board> findByWriter(String writer);

    List<Board> selectBoardSearchList(String keyword, String sort);

    List<Map<String, Object>> boardList(Criteria cri) throws Exception;



}
