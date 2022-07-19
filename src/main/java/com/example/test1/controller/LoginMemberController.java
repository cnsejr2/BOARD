package com.example.test1.controller;


import com.example.test1.domain.SecurityMember;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

@Controller
@SessionAttributes("sessionMember")
@RequestMapping("/member/login")
public class LoginMemberController {

//    @Resource
//    private MemberService memberService;
//
//    @Resource
//    private MemberRepository memberRepository;
//
//    @RequestMapping(method = RequestMethod.GET)
//    public String memberLogin1() throws Exception {
//        return "member/login";
//    }
//
//    @RequestMapping(method = RequestMethod.POST)
//    public String loginInfo(HttpServletResponse response, HttpSession session, @RequestParam(value="id") String id, @RequestParam(value="password") String password) throws Exception {
//        response.setContentType("text/html; charset=UTF-8");
//        PrintWriter out = response.getWriter();
//
//        SecurityMember member = memberRepository.findById(id);
//        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
//
//        System.out.println("password : " + password);
//        System.out.println("member.getPassword() : " + member.getPassword());
//        if (encoder.matches(password, member.getPassword())) {
//            session.setAttribute("id", member.getId());
//            session.setAttribute("name", member.getMemberName());
//            session.setAttribute("password", member.getPassword());
//            System.out.println("로그인성공");
//            out.println("<script>alert('반갑습니다.');location.href='/';</script>");
//            out.flush();
//        } else {
//            System.out.println("로그인실패");
//            out.println("<script>alert('아이디또는비밀번호가일치하지않습니다.');location.href='/';</script>");
//            out.flush();
//        }
//        return "/index";
//    }
}
