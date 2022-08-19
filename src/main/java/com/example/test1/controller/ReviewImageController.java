package com.example.test1.controller;

import com.example.test1.domain.AttachImage;
import com.example.test1.domain.ReviewFile;
import com.example.test1.domain.ReviewFile;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@Transactional
@Slf4j
public class ReviewImageController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @PostMapping(value="/uploadReviewAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<ReviewFile>> uploadAjaxActionPOST(MultipartFile uploadFile) throws IOException {

        logger.info("uploadItemAjaxAction..........");

        File checkfile = new File(uploadFile.getOriginalFilename());
        String type = null;

        try {
            type = Files.probeContentType(checkfile.toPath());
            logger.info("MIME TYPE : " + type);
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (!type.startsWith("image")) {
            List<ReviewFile> list = null;
            return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
        }
        String uploadFolder = "C:\\upload\\item";

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        String datePath = str.replace("-", File.separator);

        File uploadPath = new File(uploadFolder, datePath);

        if (uploadPath.exists() == false) {
            uploadPath.mkdirs();
        }

        List<ReviewFile> list = new ArrayList();
        ReviewFile iImage = new ReviewFile();

        String uploadItemFileName = uploadFile.getOriginalFilename();
        iImage.setOriginalFileName(uploadItemFileName);
        iImage.setFilePath(datePath);

        String uuid = UUID.randomUUID().toString();
        iImage.setUuid(uuid);

        uploadItemFileName = uuid + "_" + uploadItemFileName;

        File saveFile = new File(uploadPath, uploadItemFileName);

        try {
            uploadFile.transferTo(saveFile);

            File thumbnailFile = new File(uploadPath, "s_" + uploadItemFileName);
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
        list.add(iImage);

        ResponseEntity<List<ReviewFile>> result = new ResponseEntity<List<ReviewFile>>(list, HttpStatus.OK);
        return result;
    }
}
