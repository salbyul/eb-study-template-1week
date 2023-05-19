package com.study.dto.board;

public class BoardCreateDto {

    private String category;
    private String writer;
    private String password;
    private String title;
    private String content;

    public BoardCreateDto(String category, String writer, String password, String title, String content) {
        this.category = category;
        this.writer = writer;
        this.password = password;
        this.title = title;
        this.content = content;
    }

    public String getCategory() {
        return category;
    }

    public String getWriter() {
        return writer;
    }

    public String getPassword() {
        return password;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }
}
