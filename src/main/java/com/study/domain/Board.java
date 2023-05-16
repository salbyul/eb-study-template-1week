package com.study.domain;

import java.time.LocalDateTime;

public class Board {

    private Long board_id;
    private Long category_id;
    private String writer;
    private String password;
    private String title;
    private String content;
    private Long views;
    private LocalDateTime createdDate;
    private LocalDateTime modifiedDate;
}
