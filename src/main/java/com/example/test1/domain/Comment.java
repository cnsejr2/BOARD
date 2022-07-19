package com.example.test1.domain;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;

@Slf4j
@Getter
public class Comment {
    private Long id;

    private String writer;

    private String regDate;

    private String contents;

    private Long bid;

    @Builder
    public Comment(Long id, String writer, String contents, String regDate, Long bid) {
        this.id = id;
        this.writer = writer;
        this.contents = contents;
        this.regDate = regDate;
        this.bid = bid;
    }
}
