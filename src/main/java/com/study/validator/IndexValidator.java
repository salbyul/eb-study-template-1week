package com.study.validator;

import com.study.connection.ConnectionTest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

// 날짜 검증 : 전 후 검증은 프론트에서만
public class IndexValidator {

    private final Connection conn = new ConnectionTest().getConnection();
    private final SearchDto searchDto;

    public IndexValidator(String startDate, String endDate, String category, String search) throws Exception {
        searchDto = new SearchDto(validateDate(startDate), validateDate(endDate), validateCategory(category), validateSearch(search));
        conn.close();
    }

    public SearchDto getSearchDto() {
        return searchDto;
    }

    /**
     * 날짜형식으로 왔는지 검증
     * @param date
     * @return
     */
    private String validateDate(String date) {
        if (date == null) return null;
        String[] split = date.split("-");

        if (split.length != 3) return null;

        if (Integer.parseInt(split[0]) < 0 || Integer.parseInt(split[0]) > 9999) return null;
        if (Integer.parseInt(split[1]) < 1 || Integer.parseInt(split[1]) > 12) return null;
        if (Integer.parseInt(split[2]) < 1 || Integer.parseInt(split[2]) > 31) return null;
        return date;
    }

    /**
     * 카테고리가 알맞게 들어왔는지 검증
     * @param category
     * @return
     */
    private String validateCategory(String category) {
        if (category == null) return null;
        ArrayList<String> categoryList = new ArrayList<>();
        String sql = "select name from category";
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()){
            while (rs.next()) {
                categoryList.add(rs.getString("name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        boolean flag = false;
        for (String s : categoryList) {
            if (category.equals(s)) {
                flag = true;
                break;
            }
        }
        if (flag) return category;
        return null;
    }

    /**
     * 검색어 존재 검증
     * @param search
     * @return
     */
    private String validateSearch(String search) {
        if (search == null) return null;
        return search;
    }
}