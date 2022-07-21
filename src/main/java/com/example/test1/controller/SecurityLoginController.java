package com.example.test1.controller;

import com.example.test1.domain.*;
import com.example.test1.service.BoardService;
import com.example.test1.service.SecurityService;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotNull;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

@Controller
@Slf4j
public class SecurityLoginController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    SecurityService securityService;
    @Resource
    BoardService boardService;

    @GetMapping("/security")
    public String getIndex() {
        return "security/index";
    }

    @RequestMapping("/security/main")
    public ModelAndView getMain(Criteria cri) throws Exception {
        ModelAndView mav = new ModelAndView("/index");

        List<Board> bList = boardService.getListPaging(cri);
        mav.addObject("bList", bList);

        int total = boardService.getTotal();
        logger.info("total : " + total);
        Paging pageMake = new Paging(cri, total);

        mav.addObject("pageMaker", pageMake);
        return mav;
    }

    @GetMapping("/security/login")
    public String getLoginForm() {
        return "security/loginPage";
    }

    @GetMapping("/security/login/failure")
    public String getLoginFail() {
        return "security/loginFail";
    }

    @GetMapping("/security/login/insert")
    public String getJoin() {
        return "security/join";
    }

    @RequestMapping(value = "/security/login/insert", method = RequestMethod.POST)
    public String doJoin(SecurityMember member) {
        securityService.setInsertMember(member);
        return "security/loginPage";
    }

    @GetMapping("/error/error")
    public String goError() {
        return "/error/error";
    }

    @RequestMapping(value = "/security/login/insert/IdChk", method = RequestMethod.POST)
    @ResponseBody
    public String memberIdChkPOST(@RequestParam("id")String id) throws Exception{
        int result = securityService.idCheck(id);
        if(result != 0) {
            return "fail";	// 중복 아이디가 존재
        } else {
            return "success";	// 중복 아이디 x
        }

    }


    /* 첨부 파일 업로드 */
    @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<AttachImage>> uploadAjaxActionPOST(MultipartFile uploadFile) throws IOException {

        logger.info("uploadAjaxActionPOST..........");

        File checkfile = new File(uploadFile.getOriginalFilename());
        String type = null;

        try {
            type = Files.probeContentType(checkfile.toPath());
            logger.info("MIME TYPE : " + type);
        } catch (IOException e) {
            e.printStackTrace();
        }
        if(!type.startsWith("image")) {
            List<AttachImage> list = null;
            return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
        }
        String uploadFolder = "C:\\upload";

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        String datePath = str.replace("-", File.separator);

        /* 폴더 생성 */
        File uploadPath = new File(uploadFolder, datePath);

        if (uploadPath.exists() == false) {
            uploadPath.mkdirs();
        }
        /* 이미저 정보 담는 객체 */
        List<AttachImage> list = new ArrayList();
        AttachImage aImage = new AttachImage();
        /* 파일 이름 */
        String uploadFileName = uploadFile.getOriginalFilename();
        aImage.setFileName(uploadFileName);
        aImage.setUpload(datePath);

        /* uuid 적용 파일 이름 */
        String uuid = UUID.randomUUID().toString();
        aImage.setUuid(uuid);

        uploadFileName = uuid + "_" + uploadFileName;

        /* 파일 위치, 파일 이름을 합친 File 객체 */
        File saveFile = new File(uploadPath, uploadFileName);

        /* 파일 저장 */
        try {
            uploadFile.transferTo(saveFile);
            /*
            File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);

            BufferedImage bo_image = ImageIO.read(saveFile);
            // 비율
            double ratio = 3;
            //넓이 높이
            int width = (int) (bo_image.getWidth() / ratio);
            int height = (int) (bo_image.getHeight() / ratio);
            BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);

            Graphics2D graphic = bt_image.createGraphics();

            graphic.drawImage(bo_image, 0, 0,width,height, null);

            ImageIO.write(bt_image, "jpg", thumbnailFile);
            */
            File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
            BufferedImage bo_image = ImageIO.read(saveFile);

            //비율
            double ratio = 3;
            //넓이 높이
            int width = (int) (bo_image.getWidth() / ratio);
            int height = (int) (bo_image.getHeight() / ratio);
            Thumbnails.of(saveFile)
                    .size(width, height)
                    .toFile(thumbnailFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        list.add(aImage);

        ResponseEntity<List<AttachImage>> result = new ResponseEntity<List<AttachImage>>(list, HttpStatus.OK);
        return result;
    }

    @GetMapping("/display")
    public ResponseEntity<byte[]> getImage(String fileName){
        File file = new File("c:\\upload\\" + fileName);

        ResponseEntity<byte[]> result = null;

        try {

            HttpHeaders header = new HttpHeaders();

            header.add("Content-type", Files.probeContentType(file.toPath()));

            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);

        }catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }
}
