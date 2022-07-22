package com.example.test1.domain;

import com.example.test1.mapper.AttachMapper;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class TestTest {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    AttachMapper attachMapper;

    private String getFolderYesterDay() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);
        String str = sdf.format(cal.getTime());
        return str.replace("-", File.separator);
    }

    @Test
    @Scheduled(cron = "0 * * * * *")
    void testMethod() {
        List<AttachImage> fileList = attachMapper.checkFileList();

        System.out.println("fileList : ");
        fileList.forEach( list -> System.out.println(list));
        System.out.println("========================================");

        List<Path> checkFilePath = new ArrayList<Path>();

        fileList.forEach(vo -> {
            Path path = Paths.get("C:\\upload", vo.getUpload(), vo.getUuid() + "_" + vo.getFileName());
            checkFilePath.add(path);
        });

        System.out.println("checkFilePath : ");
        checkFilePath.forEach(list -> System.out.println(list));
        System.out.println("========================================");

        fileList.forEach(vo -> {
            Path path = Paths.get("C:\\upload", vo.getUpload(), "s_" +  vo.getUuid() + "_" + vo.getFileName());
            checkFilePath.add(path);
        });

        System.out.println("checkFilePath(썸네일 이미지 정보 추가 후) : ");
        checkFilePath.forEach(list -> System.out.println(list));
        System.out.println("========================================");
    }
}