package com.study.validator;

import com.study.connection.ConnectionTest;
import com.study.dto.board.BoardModifyDto;

import java.sql.Connection;

public class ModifyValidator {

    private final Connection conn = new ConnectionTest().getConnection();
    private final BoardModifyDto boardDto;

    public ModifyValidator(Long id, String writer, String title, String content) throws Exception {
        boardDto = new BoardModifyDto(id, validateWriter(writer), validateTitle(title), validateContent(content));
        conn.close();
    }

    public BoardModifyDto getBoardDto() {
        return boardDto;
    }

    private String validateWriter(String writer) {
        if (writer != null) {
            if (writer.length() < 3 || writer.length() > 4) {
                throw new IllegalArgumentException("writer ERROR!!");
            } else {
                return writer;
            }
        }
        throw new IllegalArgumentException("writer ERROR!!");
    }

    private String validateTitle(String title) {
        if (title != null) {
            if (title.length() < 4 || title.length() > 99) {
                throw new IllegalArgumentException("title ERROR!!");
            }
            return title;
        }
        throw new IllegalArgumentException("title ERROR!!");
    }

    private String validateContent(String content) {
        if (content != null) {
            if (content.length() < 4 || content.length() > 1999) {
                throw new IllegalArgumentException("content ERROR!!");
            }
            return content;
        }
        throw new IllegalArgumentException("content ERROR!!");
    }

}
