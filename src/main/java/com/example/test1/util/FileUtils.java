package com.example.test1.util;

import com.example.test1.domain.ItemImage;
import com.example.test1.domain.ReviewFile;
import net.coobird.thumbnailator.Thumbnails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

@Component
public class FileUtils {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    public List<ReviewFile> parseFileInfo(Long reviewId, MultipartFile[] file) throws IOException {

        List<ReviewFile> fileList = new ArrayList<>();
        String uploadFolder = "C:\\upload\\review";

        File target = new File(uploadFolder);
        if (!target.exists()) {
            target.mkdirs();
        }

        for (int i = 0; i < file.length; i++) {
            String orgFileName = file[i].getOriginalFilename();
            String orgFileExtension = orgFileName.substring(orgFileName.lastIndexOf("."));
            String saveFileName = UUID.randomUUID().toString().replaceAll("-", "") + orgFileExtension;
            Long saveFileSize = file[i].getSize();

            logger.info("============== file start ================");
            logger.info("파일 리뷰 번호 : " + reviewId);
            logger.info("파일 실제 이름 : " + orgFileName);
            logger.info("파일 저장 이름 : " + saveFileName);
            logger.info("파일 크기 : " + saveFileSize);
            logger.info("contentType : " + file[i].getContentType());
            logger.info("============== file end  =================");

            target = new File(uploadFolder, saveFileName);
            file[i].transferTo(target);

            ReviewFile reviewFile = new ReviewFile();
            reviewFile.setReviewId(reviewId);
            reviewFile.setOriginal_file_name(orgFileName);
            reviewFile.setFilePath(saveFileName);
            reviewFile.setFileSize(saveFileSize);
            fileList.add(reviewFile);

        }
        return fileList;
    }

    public List<ItemImage> parseItemImageInfo(Long itemId, MultipartFile[] file) throws IOException {

        List<ItemImage> fileList = new ArrayList<>();

        for (int i = 0; i < file.length; i++) {
            File checkfile = new File(file[i].getOriginalFilename());
            String type = null;

            String uploadFolder = "C:\\upload\\item";

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            String str = sdf.format(date);

            String datePath = str.replace("-", File.separator);

            File uploadPath = new File(uploadFolder, datePath);
            logger.info("uploadPath : " + uploadPath);
            File target = new File(uploadPath.toString());
            if (!target.exists()) {
                logger.info("디렉토리 생성");
                target.mkdirs();
            }

            ItemImage iImage = new ItemImage();
            iImage.setItemId(itemId);
            String uploadItemFileName = file[i].getOriginalFilename();
            iImage.setFileName(uploadItemFileName);
            iImage.setUpload(datePath);

            String uuid = UUID.randomUUID().toString();
            iImage.setUuid(uuid);

            uploadItemFileName = uuid + "_" + uploadItemFileName;

            File saveFile = new File(uploadPath, uploadItemFileName);

            try {
                file[i].transferTo(saveFile);

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
            fileList.add(iImage);

        }
        return fileList;
    }
}
