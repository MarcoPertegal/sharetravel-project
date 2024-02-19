package com.salesianostriana.dam.sharetravelBackend.security;

import jakarta.servlet.*;
import com.salesianostriana.dam.sharetravelBackend.user.model.User;
import com.salesianostriana.dam.sharetravelBackend.user.service.CustomUserDetailsService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
@AllArgsConstructor
public class PasswordExpirationFilter implements Filter {

    private final CustomUserDetailsService customUserDetailsService;
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String requestUrl = httpRequest.getRequestURL().toString();

        if (requestUrl.endsWith(".css") || requestUrl.endsWith(".png") || requestUrl.endsWith(".js")
                || requestUrl.endsWith(".css")){
            chain.doFilter(httpRequest, response);
            return;
        }
        System.out.println(requestUrl);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = null;
        if (authentication != null){
            principal = authentication.getPrincipal();
        }
        System.out.println("User"+principal);
        if (principal != null && principal instanceof UserDetails){
            User user = (User) principal;
            //Nose porque siempre devuelve no expired
            if (user.isPasswordExpired()){
                System.out.println("PAsword expired");
            }else {
                System.out.println("PAsword NO expired");
            }

        }

        chain.doFilter(request, response);
    }
}
