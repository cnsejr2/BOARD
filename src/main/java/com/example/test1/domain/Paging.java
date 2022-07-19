package com.example.test1.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Paging {
    private int totalCount;
    private int displayPageNum = 5;

    private int startPage;
    private int endPage;
    private boolean prev;
    private boolean next;

    private Criteria cri;

    public Criteria getCri() {
        return cri;
    }

    public int getTotalCount() { return totalCount; }
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        pagingData();
    }

    private void pagingData() {
        endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
        startPage = (endPage - displayPageNum) + 1;
        int tempEndPage = (int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
        if(endPage>tempEndPage) {
            endPage=tempEndPage;
        }
        prev=startPage==1?false:true;
        next=endPage*cri.getPerPageNum()>=totalCount?false:true;
    }
}
