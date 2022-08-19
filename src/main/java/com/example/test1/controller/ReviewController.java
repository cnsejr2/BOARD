package com.example.test1.controller;

import com.example.test1.domain.Review;
import com.example.test1.domain.ReviewFile;
import com.example.test1.service.ReviewService;
import com.example.test1.util.FileUtils;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

@Controller
@Transactional
@Slf4j
public class ReviewController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    ReviewService reviewService;

    @GetMapping("/item/review/write.do")
    public String reviewForm() {
        return "review/write";
    }

    @GetMapping("/item/review/lala")
    public String reviewForm1() {
        return "review/lala";
    }

    @RequestMapping(value = "/item/review/write.do", method = RequestMethod.POST)
    public String insertReview(MultipartFile[] file) throws IOException {
        for (int i = 0; i < file.length; i++) {
            logger.info("============== file start ================");
            logger.info("파일 이름 : " + file[i].getName());
            logger.info("파일 실제 이름 : " + file[i].getOriginalFilename());
            logger.info("파일 크기 : " + file[i].getSize());
            logger.info("contentType : " + file[i].getContentType());
            logger.info("============== file end  =================");
        }

        return "redirect:/main";
    }

//    @PostMapping("/item/review/write.do")
//    public String insertReview(Review review, HttpServletRequest request,
//                               MultipartHttpServletRequest mhsr) throws IOException {
//
//        logger.info("글 등록 처리");
//
//        //파일 업로드 처리
//        MultipartFile uploadFile = mhsr.getFile("multipartFile");
//        if(!uploadFile.isEmpty()) {
//            String fileName = uploadFile.getOriginalFilename();
//            uploadFile.transferTo(new File("C:/upload/" + fileName));
//        }
//        reviewService.insertReview(review);
//
//        FileUtils fileUtils = new FileUtils();
//        List<ReviewFile> fileList = fileUtils.parseFileInfo(Long.valueOf(1), request, mhsr);

        //화면 네비게이션(게시글 등록 완료 후 게시글 목록으로 이동)
//        return "redirect:/main";

}
