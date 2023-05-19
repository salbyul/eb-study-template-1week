package com.study.dto.comment;

public class CommentDto {

    private Long id;
    private String writer;
    private String content;
    private String createdDate;

    public CommentDto(Long id, String writer, String content, String createdDate) {
        this.id = id;
        this.writer = writer;
        this.content = content;
        this.createdDate = createdDate;
    }

    public Long getId() {
        return id;
    }

    public String getWriter() {
        return writer;
    }

    public String getContent() {
        return content;
    }

    public String getCreatedDate() {
        return createdDate;
    }
}
