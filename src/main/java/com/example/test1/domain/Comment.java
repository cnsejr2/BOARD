package com.example.test1.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

import java.util.Date;

@Slf4j
@Getter
public class Comment {
    private Long id;

    private String writer;

    private String wrdate;

    private String contents;

    private Long bid;

    @Builder
    public Comment(Long id, String writer, String contents, String wrdate, Long bid) {
        this.id = id;
        this.writer = writer;
        this.contents = contents;
        this.wrdate = wrdate;
        this.bid = bid;
    }
}
