package com.example.test1.service;

import com.example.test1.domain.AttachImage;
import com.example.test1.domain.ItemImage;
import com.example.test1.mapper.ItemImageMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Slf4j
@Service
@Transactional
public class ItemImageService {

    @Resource
    ItemImageMapper itemImageMapper;
    public List<ItemImage> getItemImageList(Long itemId) { return itemImageMapper.getItemImageList(itemId); }
    public List<ItemImage> findAllImage() { return itemImageMapper.findAllImage(); }
    public void imageReEnroll(ItemImage itemImage) { itemImageMapper.imageReEnroll(itemImage); }
    public void deleteImage(Long bId) { itemImageMapper.deleteImage(bId); }
    public void deleteImageAll(Long bId) { itemImageMapper.deleteImageAll(bId); }
    public List<ItemImage> checkFileList() { return itemImageMapper.checkFileList(); }
}
