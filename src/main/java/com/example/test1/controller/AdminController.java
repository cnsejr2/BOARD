package com.example.test1.controller;

import com.example.test1.domain.Board;
import com.example.test1.mapper.BoardMapper;
import com.example.test1.service.AttachService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.net.URLDecoder;
import java.util.List;

@Controller
@Slf4j
public class AdminController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    private BoardMapper boardMapper;

    @Resource
    AttachService attachService;

    @GetMapping("/admin/board/list")
    public ModelAndView boardForm() {
        ModelAndView mav = new ModelAndView("admin/list");
        List<Board> bList = boardMapper.findAll();
        mav.addObject("bList", bList);
        return mav;
    }

    /* 이미지 파일 삭제 */
    @PostMapping("/deleteFile")
    public ResponseEntity<String> deleteFile(String fileName, Long id){

        logger.info("deleteFile........" + fileName);

        File file = null;

        try {
            attachService.deleteImage(id);
            /* 썸네일 파일 삭제 */
            file = new File("C:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
            file.delete();

            /* 원본 파일 삭제 */
            String originFileName = file.getAbsolutePath().replace("s_", "");
            logger.info("originFileName : " + originFileName);
            file = new File(originFileName);
            file.delete();

        } catch(Exception e) {

            e.printStackTrace();

            return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);

        }
        return new ResponseEntity<String>("success", HttpStatus.OK);
    }
}
