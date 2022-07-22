package com.example.test1.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Criteria {
    /* 현재 페이지 */
    private int pageNum;

    /* 한 페이지 당 보여질 게시물 갯수 */
    private int amount;

    /* 기본 생성자 -> 기봅 세팅 : pageNum = 1, amount = 5 */
    public Criteria() {
        this(1,5);
    }

    /* 생성자 => 원하는 pageNum, 원하는 amount */
    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    @Override
    public String toString() {
        return "Criteria [pageNum=" + pageNum + ", amount=" + amount + "]";
    }
}
