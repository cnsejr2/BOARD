package com.example.test1.domain;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
public class Board {

    private Long id;

    private String title;

    private String contents;

    private String writer;

    /** 조회 수 */
    private int viewCnt;

    /** 공지 여부 */
    private String notice;

    /** 비밀 여부 */
    private String secret;

    /** 등록일 */
    private String wrdate;

    /** 수정일 */
    private String modate;

    /** 삭제일 */
    private String dedate;

    /** 추천 수 */
    private int recom_cnt;

}
