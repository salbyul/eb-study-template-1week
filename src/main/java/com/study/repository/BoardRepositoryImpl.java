package com.study.repository;

import com.study.connection.ConnectionTest;
import com.study.dto.board.BoardCreateDto;
import com.study.dto.board.BoardDetailDto;
import com.study.dto.board.BoardModifyDto;
import com.study.dto.board.BoardSearchDto;
import com.study.validator.SearchDto;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BoardRepositoryImpl implements BoardRepository {

    private final Connection conn = new ConnectionTest().getConnection();

    public BoardRepositoryImpl() throws Exception {
    }

    @Override
    public Long save(BoardCreateDto boardDto) {
        String sql = "insert into board (category_id, writer, password, title, content, views, created_date, modified_date) values((select category_id from category where name = ?), ?, ?, ?, ?, 0, ?, null)";
        Long generatedKey = 0L;

        try (PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, boardDto.getCategory());
            pstmt.setString(2, boardDto.getWriter());
            pstmt.setString(3, boardDto.getPassword());
            pstmt.setString(4, boardDto.getTitle());
            pstmt.setString(5, boardDto.getContent());
            pstmt.setString(6, String.valueOf(LocalDateTime.now()));

            int i = pstmt.executeUpdate();

            if (i > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    generatedKey = rs.getLong(1);
                }
                rs.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("generatedKey = " + generatedKey);
        return generatedKey;
    }

    @Override
    public List<BoardSearchDto> findPaging(int offset, int limit, SearchDto searchDto) {
        System.out.println(searchDto.getStartDate());
        String sql = "select board_id, name as category, title, writer, views, created_date, modified_date " +
                "from board b, category c " +
                "where b.category_id = c.category_id ";
        if (searchDto.getStartDate() != null) sql = sql + "and b.created_date >= '" + searchDto.getStartDate() + "' ";
        if (searchDto.getEndDate() != null) sql = sql + "and b.created_date <= '" + searchDto.getEndDate() + " 23:59:59' ";
        if (searchDto.getSearch() != null) sql = sql + "and (b.title like '%" + searchDto.getSearch() + "%' or b.writer like '%" + searchDto.getSearch() + "%' or b.content like '%" + searchDto.getSearch() + "%') ";
        if (searchDto.getCategory() != null) sql = sql + "and c.name = '" + searchDto.getCategory() + "' ";

        String orderBy = "order by created_date desc " +
                "limit ? offset ?;";
        sql += orderBy;
        List<BoardSearchDto> list = new ArrayList<>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            pstmt.setInt(2, offset * limit);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                list.add(new BoardSearchDto(rs.getLong("board_id"), rs.getString("category"), rs.getString("title"), rs.getString("writer"), rs.getLong("views"), rs.getString("created_date"), rs.getString("modified_date")));
                System.out.println("board_id = " + rs.getLong("board_id"));
            }
            pstmt.close();
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return list;
    }

    @Override
    public Integer findCountBySearchDto(SearchDto searchDto) {
        int i = 0;
        String sql = "select count(b.board_id) " +
                "from board b, category c " +
                "where b.category_id = c.category_id ";

        if (searchDto.getStartDate() != null) sql = sql + "and b.created_date >= '" + searchDto.getStartDate() + "' ";
        if (searchDto.getEndDate() != null) sql = sql + "and b.created_date <= '" + searchDto.getEndDate() + " 23:59:59' ";
        if (searchDto.getSearch() != null) sql = sql + "and (b.title like '%" + searchDto.getSearch() + "%' or b.writer like '%" + searchDto.getSearch() + "%' or b.content like '%" + searchDto.getSearch() + "%') ";
        if (searchDto.getCategory() != null) sql = sql + "and c.name = '" + searchDto.getCategory() + "' ";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)){
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    @Override
    public Integer countAll() {
        String sql = "select count(board_id) as count from board";
        Integer count;
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            rs.next();
            count = Integer.parseInt(rs.getString("count"));
            return count;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public BoardDetailDto findDetailByIndex(Long index) {
        String sql = "select board_id, title, content, created_date, modified_date, writer, views, name as category from board, category where board_id = ? and category.category_id = board.category_id";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, index);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                long boardId = rs.getLong("board_id");
                String title = rs.getString("title");
                String category = rs.getString("category");
                String content = rs.getString("content");
                String createdDate = rs.getString("created_date");
                String modifiedDate = rs.getString("modified_date");
                String writer = rs.getString("writer");
                int views = rs.getInt("views");
                rs.close();
                return new BoardDetailDto(boardId, category, title, views, content, createdDate, modifiedDate, writer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateViews(int views, Long boardId) {
        String sql = "update board set views = ? + 1 where board_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, views);
            pstmt.setLong(2, boardId);
            int i = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String findPasswordById(Long boardId) {
        String sql = "select password from board where board_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setLong(1, boardId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getString("password");
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void modifyBoard(BoardModifyDto boardModifyDto) {
        String sql = "update board set writer = ?, title = ?, content = ?, modified_date = ? where board_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1, boardModifyDto.getWriter());
            pstmt.setString(2, boardModifyDto.getTitle());
            pstmt.setString(3, boardModifyDto.getContent());
            pstmt.setString(4, boardModifyDto.getModifiedDate().toString());
            pstmt.setLong(5, boardModifyDto.getId());
            int i = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(Long boardId) {
        String sql = "delete from board where board_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setLong(1, boardId);
            int i = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<String> findCategories() {
        String sql = "select name from category";
        List<String> list = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void close() throws SQLException {
        conn.close();
    }

}
