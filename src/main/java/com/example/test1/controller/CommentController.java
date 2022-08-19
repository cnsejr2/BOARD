package com.example.test1.controller;

import com.example.test1.domain.Comment;
import com.example.test1.service.CommentService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
public class CommentController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    CommentService commentService;
    @GetMapping("/getCommentList")
    @ResponseBody
    private List<Comment> getCommentList(@RequestParam("id") Long id) throws Exception {
        return commentService.selectCommentList(id);
    }
    @PostMapping("/board/comment/write")
    private String insertComment(Principal principal, @RequestParam("id") Long id,
                                 @RequestParam("contents") String contents) throws Exception {
        String writer = principal.getName();
        Comment comment = Comment.builder()
                .writer(writer)
                .contents(contents)
                .bid(id)
                .build();
        commentService.insertComment(comment);
        return "redirect:/board/view/" + id;
    }

    /* 댓글 수정 */
    @RequestMapping(value = "/board/{id}/comment/update/{cid}", method = RequestMethod.PUT)
    public String updateComment(@PathVariable("id") Long id,
                                @PathVariable("cid") String cid,
                                 @RequestParam("contents") String contents) throws Exception {
        Map<String, String> input = new HashMap<>();
        input.put("cid", cid);
        input.put("contents", contents);
        commentService.updateComment(input);
        return "redirect:/board/view/" + id;
    }

    /* 게시글 삭제 페이지 */
    @RequestMapping(value="/comment/delete", method = RequestMethod.GET)
    public String deleteComment(@RequestParam("id") Long id,
                              @RequestParam("bid") Long bid) throws Exception {
        commentService.deleteComment(id);
        return "redirect:/board/view/" + bid;
    }

    @ResponseBody
    @DeleteMapping("/comment/multi/delete")
    public List<Long> deleteSubmit(@RequestBody List<Long> comIdxArray){
        commentService.deleteMultiComment(comIdxArray);
        return comIdxArray;
    }
}
