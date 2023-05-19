package com.study.validator;

import com.study.connection.ConnectionTest;
import com.study.dto.board.BoardCreateDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CreateValidator {

    private final Connection conn = new ConnectionTest().getConnection();
    private final BoardCreateDto boardDto;

    public CreateValidator(String category, String writer, String password, String title, String content) throws Exception {
        boardDto = new BoardCreateDto(validateCategory(category), validateWriter(writer), validatePassword(password), validateTitle(title), validateContent(content));
        conn.close();
    }

    public BoardCreateDto getBoardDto() {
        return boardDto;
    }

    private String validateCategory(String category) {
        ArrayList<String> categoryList = new ArrayList<>();
        String sql = "select name from category";
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                categoryList.add(rs.getString("name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        boolean flag = false;
        if (category != null) {
            for (String s : categoryList) {
                if (s.equals(category)) {
                    flag = true;
                    break;
                }
            }
        }
        if (flag) {
            return category;
        } else {
            throw new IllegalArgumentException("category ERROR!!");
        }
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

    private String validatePassword(String password) {

//        SHA256 알고리즘
        return password;
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
