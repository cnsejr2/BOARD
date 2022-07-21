package com.example.test1.service;

import com.example.test1.domain.AttachImage;
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

    /* 게시판 목록(페이징 적용) */
    public List<Board> getListPaging(Criteria cri) { return boardMapper.getListPaging(cri); }

    public int getTotal() { return boardMapper.getTotal(); }

    public  void updateRecommend(Long bid) { boardMapper.updateRecommend(bid);}

    public  void saveRecommendBoard(Long bid, String mid) { boardMapper.saveRecommendBoard(bid, mid); }

    public  int hadRecommend(Long bid, String mid) { return  boardMapper.hadRecommend(bid, mid); }

    public void imageEnroll(AttachImage attachImage) { boardMapper.imageEnroll(attachImage); }

}
