package com.study.validator;

import com.study.connection.ConnectionTest;

import java.time.LocalDate;
import java.util.List;

// 날짜 검증 : 전 후 검증은 프론트에서만
public class IndexValidator {

    private final SearchDto searchDto;

    public IndexValidator(String startDate, String endDate, String category, String search, List<String> categoryList) {
        searchDto = new SearchDto(validateDate(startDate), validateDate(endDate), validateCategory(category, categoryList), validateSearch(search));
    }

    /**
     * 날짜형식으로 왔는지 검증
     * @param date
     * @return
     */
    private LocalDate validateDate(String date) {
        if (date.equals("")) return null;
        String[] split = date.split("-");

        if (split.length != 3) return null;

        int year, month, day;

        try {
            year = Integer.parseInt(split[0]);
            month = Integer.parseInt(split[1]);
            day = Integer.parseInt(split[2]);
        } catch (NumberFormatException e) {
            return null;
        }


        return LocalDate.of(year, month, day);
    }

    /**
     * 카테고리가 알맞게 들어왔는지 검증
     * @param category
     * @param categoryList
     * @return
     */
    private String validateCategory(String category, List<String> categoryList) {
        if (category.equals("")) return null;
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
        if (search.equals("")) return null;
        return search;
    }
}