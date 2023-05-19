package com.study.repository;

import com.study.connection.ConnectionTest;
import com.study.dto.comment.CommentDto;
import com.study.dto.comment.CommentSaveDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CommentRepositoryImpl implements CommentRepository{

    private final Connection conn = new ConnectionTest().getConnection();

    public CommentRepositoryImpl() throws Exception {
    }

    @Override
    public void save(CommentSaveDto commentSaveDto) {
        String sql = "insert into comment values(get_seq('comment_seq'), ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, commentSaveDto.getWriter());
            pstmt.setString(2, commentSaveDto.getContent());
            pstmt.setString(3, String.valueOf(LocalDateTime.now()));
            pstmt.setLong(4, commentSaveDto.getBoardId());

            int i = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<CommentDto> findByBoardId(Long boardId) {
        ArrayList<CommentDto> list = new ArrayList<>();
        String sql = "select * from comment where board_id = ? order by created_date";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, boardId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                list.add(new CommentDto(rs.getLong("comment_id"), rs.getString("writer"), rs.getString("content"), rs.getString("created_date")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void close() throws SQLException {
        conn.close();
    }
}
