package com.study.dto.board;

public class BoardSearchDto {

    private Long id;
    private String category;
    private String title;
    private String writer;
    private Long views;
    private String createdDate;
    private String modifiedDate;
    private Boolean hasFile;

    public BoardSearchDto(Long id, String category, String title, String writer, Long views, String createdDate, String modifiedDate) {
        this.id = id;
        this.category = category;
        this.title = title;
        this.writer = writer;
        this.views = views;
        this.createdDate = createdDate;
        this.modifiedDate = modifiedDate;
        this.hasFile = false;
    }

    public void setHasFile(Boolean hasFile) {
        this.hasFile = hasFile;
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

    public String getWriter() {
        return writer;
    }

    public Long getViews() {
        return views;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public String getModifiedDate() {
        return modifiedDate;
    }

    public boolean hasFile() {
        return hasFile;
    }
}
