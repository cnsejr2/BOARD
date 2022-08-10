package com.example.test1.controller;

import com.example.test1.domain.AttachImage;
import com.example.test1.domain.ItemImage;
import com.example.test1.service.AttachService;
import com.example.test1.service.BoardService;
import com.example.test1.service.ItemImageService;
import com.example.test1.service.SecurityService;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
@Controller
@Slf4j
public class AttachImageController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    AttachService attachService;

    @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<AttachImage>> uploadAjaxActionPOST(MultipartFile[] uploadFile) throws IOException {

        logger.info("uploadAjaxActionPOST..........");
        for(MultipartFile multipartFile: uploadFile) {
            logger.info("-----------------------------------------------");
            logger.info("파일 이름 : " + multipartFile.getOriginalFilename());
            logger.info("파일 타입 : " + multipartFile.getContentType());
            logger.info("파일 크기 : " + multipartFile.getSize());

        }
        for (MultipartFile multipartFile: uploadFile) {
            File checkfile = new File(multipartFile.getOriginalFilename());
            String type = null;

            try {
                type = Files.probeContentType(checkfile.toPath());
                logger.info("MIME TYPE : " + type);
            } catch (IOException e) {
                e.printStackTrace();
            }
            if (!type.startsWith("image")) {
                List<AttachImage> list = null;
                return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
            }
        }
        String uploadFolder = "C:\\upload";

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        String datePath = str.replace("-", File.separator);

        File uploadPath = new File(uploadFolder, datePath);

        if (uploadPath.exists() == false) {
            uploadPath.mkdirs();
        }

        List<AttachImage> list = new ArrayList();

        for (MultipartFile multipartFile : uploadFile) {
            AttachImage aImage = new AttachImage();
            String uploadFileName = multipartFile.getOriginalFilename();
            aImage.setFileName(uploadFileName);
            aImage.setUpload(datePath);

            String uuid = UUID.randomUUID().toString();
            aImage.setUuid(uuid);

            uploadFileName = uuid + "_" + uploadFileName;

            File saveFile = new File(uploadPath, uploadFileName);

            try {
                multipartFile.transferTo(saveFile);

                File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
                BufferedImage bo_image = ImageIO.read(saveFile);


                double ratio = 3;

                int width = (int) (bo_image.getWidth() / ratio);
                int height = (int) (bo_image.getHeight() / ratio);
                Thumbnails.of(saveFile)
                        .size(width, height)
                        .toFile(thumbnailFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
            list.add(aImage);
        }


        ResponseEntity<List<AttachImage>> result = new ResponseEntity<List<AttachImage>>(list, HttpStatus.OK);
        return result;
    }

    @GetMapping("/display")
    public ResponseEntity<byte[]> getImage(String fileName) {
        File file = new File("c:\\upload\\" + fileName);

        ResponseEntity<byte[]> result = null;

        try {
            HttpHeaders header = new HttpHeaders();
            header.add("Content-type", Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }

    /* 이미지 정보 반환 */
    @GetMapping(value="/getAttachList")
    public ResponseEntity<List<AttachImage>> getAttachList(Long bId) {
        return new ResponseEntity(attachService.getAttachList(bId), HttpStatus.OK);
    }
}
