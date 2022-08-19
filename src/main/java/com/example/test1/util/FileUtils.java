package com.example.test1.util;

import com.example.test1.domain.ReviewFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
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
}
