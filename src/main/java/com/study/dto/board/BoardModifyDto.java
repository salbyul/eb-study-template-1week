package com.study.dto.board;

import java.time.LocalDateTime;

public class BoardModifyDto {

    private Long id;
    private String writer;
    private String title;
    private String content;
    private LocalDateTime modifiedDate;

    public BoardModifyDto(Long id, String writer, String title, String content) {
        this.id = id;
        this.writer = writer;
        this.title = title;
        this.content = content;
        this.modifiedDate = LocalDateTime.now();
    }

    public String getWriter() {
        return writer;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public LocalDateTime getModifiedDate() {
        return modifiedDate;
    }

    public Long getId() {
        return id;
    }
}
