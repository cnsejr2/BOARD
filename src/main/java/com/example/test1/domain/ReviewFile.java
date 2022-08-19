package com.example.test1.domain;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
public class ReviewFile {
    private Long reviewId;
    private Long fileId;
    private String uuid;
    private String originalFileName;
    private Long fileSize;
    private String filePath;
}
