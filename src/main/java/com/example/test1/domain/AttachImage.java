package com.example.test1.domain;

import lombok.Data;

@Data
public class AttachImage {
    /* 경로 */
    private String upload;

    /* uuid */
    private String uuid;

    /* 파일 이름 */
    private String fileName;

    /* 상품 id */
    private Long bId;
}
