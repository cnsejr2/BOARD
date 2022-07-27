package com.example.test1.controller;

import com.example.test1.domain.ItemImage;
import com.example.test1.domain.ItemImage;
import com.example.test1.service.AttachService;
import com.example.test1.service.ItemImageService;
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
public class ItemImageController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    ItemImageService itemImageService;
    @PostMapping(value="/uploadItemAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<ItemImage>> uploadAjaxActionPOST(MultipartFile uploadFile) throws IOException {

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
            List<ItemImage> list = null;
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

        List<ItemImage> list = new ArrayList();
        ItemImage iImage = new ItemImage();

        String uploadItemFileName = uploadFile.getOriginalFilename();
        iImage.setFileName(uploadItemFileName);
        iImage.setUpload(datePath);

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

        ResponseEntity<List<ItemImage>> result = new ResponseEntity<List<ItemImage>>(list, HttpStatus.OK);
        return result;
    }

    @GetMapping("/displayItem")
    public ResponseEntity<byte[]> getImage(String fileName) {
        File file = new File("c:\\upload\\item\\" + fileName);

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
    @GetMapping(value="/getItemImageList")
    public ResponseEntity<List<ItemImage>> getItemImageList(Long itemId) {
        log.info("/getItemImageList : " + itemId);
        return new ResponseEntity(itemImageService.getItemImage(itemId), HttpStatus.OK);
    }
}
