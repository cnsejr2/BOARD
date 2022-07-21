package com.example.test1.mapper;

import com.example.test1.domain.AttachImage;
import com.example.test1.domain.Board;
import com.example.test1.domain.Comment;
import com.example.test1.domain.Criteria;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
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

    /* 게시판 목록(페이징 적용) */
    List<Board> getListPaging(Criteria cri);


    List<Board> selectBoardSearchList(@Param("keyword") String keyword, @Param("sort") String sort);

    /* 게시판 총 갯수 */
    int getTotal();

    void updateRecommend(Long id);

    void saveRecommendBoard(@Param("bid") Long bid, @Param("mid") String mid);

    int hadRecommend(@Param("bid") Long bid, @Param("mid") String mid);
    /* 이미지 등록 */
    void imageEnroll(AttachImage attachImage);


}
