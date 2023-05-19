package com.study.dto.board;

import com.study.dto.comment.CommentDto;
import com.study.dto.FileDto;

import java.util.ArrayList;
import java.util.List;

public class BoardDetailDto {

    private Long id;
    private String category;
    private String title;
    private String writer;
    private int views;
    private String content;
    private String createdDate;
    private String modifiedDate;
    private final List<FileDto> fileList = new ArrayList<>();
    private final List<CommentDto> comments = new ArrayList<>();

    public BoardDetailDto(Long id, String category, String title, int views, String content, String createdDate, String modifiedDate, String writer) {
        this.id = id;
        this.category = category;
        this.title = title;
        this.views = views;
        this.content = content;
        this.createdDate = createdDate;
        this.modifiedDate = modifiedDate;
        this.writer = writer;
    }

    public Long getId() {
        return id;
    }

    public String getCategory() {
        return category;
    }

    public String getTitle() {
        return title;
    }

    public int getViews() {
        return views;
    }

    public String getContent() {
        return content;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public String getModifiedDate() {
        return modifiedDate;
    }

    public List<FileDto> getFileList() {
        return fileList;
    }

    public List<CommentDto> getComments() {
        return comments;
    }

    public String getWriter() {
        return writer;
    }
}
