package com.study.validator;

import java.time.LocalDate;

public class SearchDto {

    private final String startDate;
    private final String endDate;
    private final String category;
    private final String search;

    public SearchDto(String startDate, String endDate, String category, String search) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.category = category;
        this.search = search;
    }

    public String getStartDate() {
        return startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public String getCategory() {
        return category;
    }

    public String getSearch() {
        return search;
    }
}
