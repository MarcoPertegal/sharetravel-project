package com.salesianostriana.dam.sharetravelBackend.security;

import com.salesianostriana.dam.sharetravelBackend.security.errorhandling.JwtAccessDeniedHandler;
import com.salesianostriana.dam.sharetravelBackend.security.errorhandling.JwtAuthenticationEntryPoint;
import com.salesianostriana.dam.sharetravelBackend.security.jwt.access.JwtAuthenticationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import static org.springframework.security.web.util.matcher.AntPathRequestMatcher.antMatcher;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@RequiredArgsConstructor
public class SecurityConfig {

    private final UserDetailsService userDetailsService;
    private final PasswordEncoder passwordEncoder;

    private final JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;
    private final JwtAccessDeniedHandler jwtAccessDeniedHandler;
    private final JwtAuthenticationFilter jwtAuthenticationFilter;

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        AuthenticationManagerBuilder authenticationManagerBuilder =
                http.getSharedObject(AuthenticationManagerBuilder.class);


        AuthenticationManager authenticationManager =
                authenticationManagerBuilder.authenticationProvider(authenticationProvider())
                        .build();

        return authenticationManager;

    }


    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();

        authenticationProvider.setUserDetailsService(userDetailsService);
        authenticationProvider.setPasswordEncoder(passwordEncoder);
        authenticationProvider.setHideUserNotFoundExceptions(false);

        return authenticationProvider;

    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        http
                .cors(Customizer.withDefaults())
                .csrf((csrf)-> csrf
                        .ignoringRequestMatchers(antMatcher("/**")))
                .exceptionHandling((exceptionHandling) -> exceptionHandling
                        .authenticationEntryPoint(jwtAuthenticationEntryPoint)
                        .accessDeniedHandler(jwtAccessDeniedHandler)
                )
                .sessionManagement((session) -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests((authz) -> authz
                        .requestMatchers(antMatcher("/user/details")).hasAnyRole("PASSENGER", "DRIVER")
                        .requestMatchers(antMatcher("/trip/new")).hasRole("DRIVER")
                        .requestMatchers(antMatcher("/trip/")).hasRole("ADMIN")
                        .requestMatchers(antMatcher("/trip/driver")).hasRole("DRIVER")
                        .requestMatchers(antMatcher("/trip/**")).hasAnyRole("PASSENGER", "DRIVER", "ADMIN")
                        .requestMatchers(antMatcher("/reserve/new")).hasRole("PASSENGER")
                        .requestMatchers(antMatcher("/reserve/passenger")).hasRole("PASSENGER")
                        .requestMatchers(antMatcher("/reserve/")).hasRole("ADMIN")
                        .requestMatchers(antMatcher("/reserve/**")).hasAnyRole("PASSENGER", "ADMIN")
                        .requestMatchers(antMatcher("/rating/driver")).hasRole("DRIVER")
                        .requestMatchers(antMatcher("/rating/new")).hasRole("PASSENGER")
                        .requestMatchers(antMatcher("/rating/")).hasRole("ADMIN")
                        .requestMatchers(antMatcher("/rating/driver")).hasRole("DRIVER")
                        .requestMatchers(antMatcher("/rating/**")).hasAnyRole("PASSENGER", "ADMIN")
                        .requestMatchers(antMatcher("/user/**")).hasRole("ADMIN")
                        .requestMatchers(antMatcher("/auth/register/admin")).hasRole("ADMIN")
                        .anyRequest().authenticated());



        http.addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);


        http.headers((headers) -> headers
                .frameOptions(opt -> opt.disable()));

        return http.build();
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web -> web.ignoring()
                .requestMatchers(
                        antMatcher("/h2-console/**"),
                        antMatcher("/api-docs"),
                        antMatcher("/auth/register/driver"),
                        antMatcher("/auth/register/passenger"),
                        antMatcher("/auth/login"),
                        antMatcher("/error"),
                        antMatcher("/refreshtoken"),
                        antMatcher("/api-docs/**")
                ));

    }


}
