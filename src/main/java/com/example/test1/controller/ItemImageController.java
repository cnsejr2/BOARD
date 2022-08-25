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
    @GetMapping(value="/getItemImageList")
    public ResponseEntity<List<ItemImage>> getItemImageList(Long itemId) {
        return new ResponseEntity(itemImageService.getItemImage(itemId), HttpStatus.OK);
    }
}
