package com.example.test1.service;

import com.example.test1.domain.Board;
import com.example.test1.domain.Criteria;
import com.example.test1.mapper.BoardMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@Transactional
public class BoardService {

    @Resource
    BoardMapper boardMapper;

    public void viewCntBoard(Board board) { boardMapper.viewCntBoard(board); }

    public void insertBoard(Board board){
        boardMapper.insertBoard(board);
    }

    public int updateBoard(Board board) { return boardMapper.updateBoard(board); }
    public void deleteBoard(Long id) { boardMapper.deleteBoard(id); }

    public List<Board> findAll() { return boardMapper.findAll(); }

    public Board selectBoardDetail(Long id) { return boardMapper.selectBoardDetail(id); }

    public List<Board> findByWriter(String writer) { return boardMapper.findByWriter(writer); }

    public List<Board> selectBoardSearchList(String keyword, String sort) { return  boardMapper.selectBoardSearchList(keyword, sort); }

    public int boardListCnt() { return boardMapper.boardListCnt(); }

    public List<Map<String, Object>> boardList(Criteria cri) throws Exception {
        return boardMapper.boardList(cri);
    }


}
