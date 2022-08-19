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
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Component
public class FileUtils {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    public List<ReviewFile> parseFileInfo(Long seq, HttpServletRequest request,
                                          MultipartHttpServletRequest mhsr) throws IOException {
        if(ObjectUtils.isEmpty(mhsr)) {
            return null;
        }

        List<ReviewFile> fileList = new ArrayList<ReviewFile>();

        //서버의 절대 경로 얻기
        String root_path = request.getSession().getServletContext().getRealPath("/");
        String attach_path = "upload\\review\\";
        logger.info(root_path + attach_path);
        //위 경로의 폴더가 없으면 폴더 생성
        File file = new File(root_path + attach_path);
        if(file.exists() == false) {
            file.mkdir();
        }

        //파일 이름들을 iterator로 담음
        Iterator<String> iterator = mhsr.getFileNames();

        while(iterator.hasNext()) {
            //파일명으로 파일 리스트 꺼내오기
            List<MultipartFile> list = mhsr.getFiles(iterator.next());

            //파일 리스트 개수 만큼 리턴할 파일 리스트에 담아주고 생성
            for(MultipartFile mf : list) {
                ReviewFile reviewFile = new ReviewFile();
                reviewFile.setFileId(seq);
                reviewFile.setFileSize(mf.getSize());
                reviewFile.setOriginalFileName(mf.getOriginalFilename());
                reviewFile.setFilePath(root_path + attach_path);
                fileList.add(reviewFile);
                String fullFilePath = root_path + attach_path + mf.getOriginalFilename();
                Path path = Paths.get(fullFilePath).toAbsolutePath();

                mf = mhsr.getFile(reviewFile.getOriginalFileName());
                mf.transferTo(path.toFile());
            }
        }
        return fileList;
    }
}
