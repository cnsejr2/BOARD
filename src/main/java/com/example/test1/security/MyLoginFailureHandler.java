package com.example.test1.security;

import com.example.test1.mapper.SecurityMemberMapper;
import com.example.test1.service.SecurityService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@Slf4j
@Component
public class MyLoginFailureHandler implements AuthenticationFailureHandler {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    SecurityMemberMapper securityMemberMapper;

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        logger.info("Hi MyLoginFailureHandler");
        HttpSession session = request.getSession();
        int result = securityMemberMapper.idCheck(request.getParameter("username"));
        if (result == 1) {
            session.setAttribute("result", "fail1");
        } else {
            session.setAttribute("result", "fail2");
        }

        response.sendRedirect("/security/login");

    }
}
