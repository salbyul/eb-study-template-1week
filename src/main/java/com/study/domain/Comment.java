package com.study.domain;

import java.time.LocalDateTime;

public class Comment {

    private Long comment_id;
    private String writer;
    private String content;
    private LocalDateTime createdDate;
    private Long board_id;
}
