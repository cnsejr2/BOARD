package com.example.test1.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;
@Slf4j
@Getter @Setter
public class PersistentLogins {

    private String series;

    private String username;

    private String token;

    private LocalDateTime lastUsed;
}
