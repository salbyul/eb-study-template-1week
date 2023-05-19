package com.study.domain;

import java.time.LocalDateTime;

public class Board {

    private Long id;
    private Long categoryId;
    private String writer;
    private String password;
    private String title;
    private String content;
    private Long views;
    private LocalDateTime createdDate;
    private LocalDateTime modifiedDate;


    public Board(Long categoryId, String writer, String password, String title, String content) {

        this.categoryId = categoryId;
        this.writer = writer;
        this.password = password;
        this.title = title;
        this.content = content;
        this.views = 0L;
        this.createdDate = LocalDateTime.now();
    }
}
