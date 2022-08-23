package com.example.test1.controller;

import com.example.test1.domain.AttachImage;
import com.example.test1.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.bind.annotation.PostMapping;

import javax.annotation.Resource;
import java.io.File;
import java.net.URLDecoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

public class AdminFileController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    AttachService attachService;

    @PostMapping("/deleteFile")
    public ResponseEntity<String> deleteFile(String fileName, Long id) {

        File file = null;

        try {
            attachService.deleteImage(id);
            /* 썸네일 파일 삭제 */
            file = new File("C:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
            file.delete();

            /* 원본 파일 삭제 */
            String originFileName = file.getAbsolutePath().replace("s_", "");
            file = new File(originFileName);
            file.delete();

        } catch (Exception e) {

            e.printStackTrace();

            return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);

        }
        return new ResponseEntity<String>("success", HttpStatus.OK);
    }

    @PostMapping("/deleteItemFile")
    public ResponseEntity<String> deleteItemFile(String fileName, Long id) {

        File file = null;

        try {
            attachService.deleteImage(id);
            /* 썸네일 파일 삭제 */
            file = new File("C:\\upload\\item\\" + URLDecoder.decode(fileName, "UTF-8"));
            file.delete();

            /* 원본 파일 삭제 */
            String originFileName = file.getAbsolutePath().replace("s_", "");
            file = new File(originFileName);
            file.delete();

        } catch (Exception e) {

            e.printStackTrace();

            return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);

        }
        return new ResponseEntity<String>("success", HttpStatus.OK);
    }

    private String getFolderToDay() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Calendar cal = Calendar.getInstance();

        cal.add(Calendar.DATE, 0);

        String str = sdf.format(cal.getTime());

        return str.replace("-", File.separator);
    }

    @Scheduled(fixedDelay = 500000)
    public void checkFiles() throws Exception {

        logger.warn("File Check Task Run..........");
        logger.warn(String.valueOf(new Date()));
        logger.warn("========================================");

        // DB에 저장된 파일 리스트
        List<AttachImage> fileList = attachService.checkFileList();

        // 비교 기준 파일 리스트(Path객체)
        List<Path> checkFilePath = new ArrayList<Path>();
        //원본 이미지
        fileList.forEach(vo -> {
            Path path = Paths.get("c:\\upload", vo.getUpload(), vo.getUuid() + "_" + vo.getFileName());
            checkFilePath.add(path);
        });
        //썸네일 이미지
        fileList.forEach(vo -> {
            Path path = Paths.get("c:\\upload", vo.getUpload(), "s_" + vo.getUuid() + "_" + vo.getFileName());
            checkFilePath.add(path);
        });


        // 디렉토리 파일 리스트
        File targetDir = Paths.get("C:\\upload", getFolderToDay()).toFile();
        File[] targetFile = targetDir.listFiles();
        if (targetFile != null) {
            // 삭제 대상 파일 리스트(분류)
            List<File> removeFileList = new ArrayList<File>(Arrays.asList(targetFile));
            for (File file : targetFile) {
                checkFilePath.forEach(checkFile -> {
                    if (file.toPath().equals(checkFile))
                        removeFileList.remove(file);
                });
            }

            for (File file : removeFileList) {
                logger.warn(String.valueOf(file));
                file.delete();
            }
        }
        logger.warn("========================================");

    }
}
