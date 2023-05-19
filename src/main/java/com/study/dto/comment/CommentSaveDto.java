package com.study.dto.comment;

public class CommentSaveDto {

    private String writer;
    private String content;
    private Long boardId;

    public CommentSaveDto(String writer, String content, Long boardId) {
        this.writer = writer;
        this.content = content;
        this.boardId = boardId;
    }

    public String getWriter() {
        return writer;
    }

    public String getContent() {
        return content;
    }

    public Long getBoardId() {
        return boardId;
    }
}
