package com.example.test1.domain;

public class Criteria {
    // 특정 페이지 조회를 위한 클래스
    private int page; // 현재 페이지 번호
    private int perPageNum; // 페이지당 보여줄 게시글의 개수

    // 특정 페이지의 범위를 정하는 구간
    public int getPageStart() {
        return (this.page - 1) * perPageNum;
    }

    public Criteria() {
        this.page = 1;
        this.perPageNum = 5;
    }

    public int getPage() { return page; }
    public void setPage(int page) {
        if (page <= 0) {
            this.page = 1;
        } else {
            this.page = page;
        }
    }

    public int getPerPageNum() { return perPageNum; }
    public void setPerPageNum(int perPageNum) {
        int cnt = this.perPageNum;

        if (perPageNum != cnt) {
            this.perPageNum = cnt;
        } else {
            this.perPageNum = perPageNum;
        }
    }

    @Override
    public String toString() {
        return "Criteria [page=]" + page + ", perPageNum=" + perPageNum + "]";
    }

}
