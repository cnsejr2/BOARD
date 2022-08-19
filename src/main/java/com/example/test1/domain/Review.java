package com.example.test1.domain;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
@Slf4j
public class Review {
    private Long reviewId;
    private String memberId;
    private Long itemId;
    private String content;
    private String wrdate;
    private int star;
    private List<ReviewFile> multipartFile;
}
