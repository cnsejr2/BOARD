package com.example.test1.controller;

import com.example.test1.domain.*;
import com.example.test1.mapper.BoardMapper;
import com.example.test1.service.*;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.net.URLDecoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@Slf4j
@EnableScheduling
public class AdminController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    AdminService adminService;
    @Resource
    BoardService boardService;
    @Resource
    CommentService commentService;
    @Resource
    AttachService attachService;
    @Resource
    ItemService itemService;
    @Resource
    ItemImageService itemImageService;

    @GetMapping("/admin/board/list")
    public ModelAndView boardForm() {
        ModelAndView mav = new ModelAndView("admin/list");
        List<Board> bList = boardService.findAll();
        mav.addObject("bList", bList);
        return mav;
    }

    @GetMapping("/admin/main")
    public ModelAndView adminMain() {
        ModelAndView mav = new ModelAndView("/admin/main");
        return mav;
    }

    @GetMapping("/admin/memberInfo")
    public ModelAndView adminMemberInfo() {
        ModelAndView mav = new ModelAndView("/admin/memberInfo");
        logger.info("service : " + adminService);
        List<SecurityMember> mList = adminService.findMemberList();
        mav.addObject("mList", mList);
        return mav;
    }
    @RequestMapping("/admin/profile/{id}")
    public ModelAndView viewMemberProfile(@PathVariable("id") String id,
                                          @RequestParam(value="type", defaultValue = "") String type,
                                          Criteria cri) throws Exception {
        ModelAndView mav = new ModelAndView("/admin/profile");

        SecurityMember sMember = adminService.findMember(id);
        mav.addObject("member", sMember);
        Criteria boardCri = new Criteria(1, 5);
        Criteria commentCri = new Criteria(1, 5);
        Criteria wishCri = new Criteria(1, 5);
        int num = 0;
        if (type.equals("board")) {
            boardCri = cri;
        } else if (type.equals("comment")) {
            commentCri = cri;
            num = 1;
        } else if (type.equals("wish")) {
            wishCri = cri;
            num = 2;
        }

        List<Board> bList = boardService.getListPagingByWriter(id, boardCri);
        int bTotal = boardService.getTotalByWriter(id);
        mav.addObject("bList", bList);
        Paging pageMake = new Paging(boardCri, bTotal);
        mav.addObject("pageMake", pageMake);

        List<Comment> cList = commentService.findCommentPagingByWriter(id, commentCri);
        int cTotal = commentService.getTotalCommentByWriter(id);
        mav.addObject("cList", cList);
        Paging pageComMake = new Paging(commentCri, cTotal);
        mav.addObject("pageComMake", pageComMake);

        List<WishItem> wList = itemService.getListPagingWishItemById(id, wishCri);
        int wTotal = itemService.getTotalWishItemById(id);
        wList.forEach(item -> {

            Long itemId = item.getItemId();

            Item i = itemService.selectItemDetail(itemId);
            item.setItem(i);

            List<ItemImage> imageList = itemImageService.getItemImage(itemId);
            item.getItem().setImageList(imageList);


            logger.info("imageList : " + item.getItem().getImageList());

        });
        mav.addObject("wList", wList);
        Paging pageWishMake = new Paging(commentCri, wTotal);
        mav.addObject("pageWishMake", pageWishMake);

        mav.addObject("type", num);

        return mav;
    }

    @ResponseBody
    @DeleteMapping("/admin/member/delete")
    public String deleteWishSubmit(@RequestParam("id") String id){
        adminService.deleteMember(id);
        return id;
    }
    /* 이미지 파일 삭제 */
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

        } catch(Exception e) {

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

        } catch(Exception e) {

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
    @Scheduled(fixedDelay=500000)
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
            Path path = Paths.get("c:\\upload", vo.getUpload(), "s_" +  vo.getUuid() + "_" + vo.getFileName());
            checkFilePath.add(path);
        });


        // 디렉토리 파일 리스트
        File targetDir = Paths.get("C:\\upload", getFolderToDay()).toFile();
        File[] targetFile = targetDir.listFiles();
        if(targetFile != null) {
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
        log.warn("========================================");

    }
}
