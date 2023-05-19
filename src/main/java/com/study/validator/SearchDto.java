package com.study.validator;

import java.time.LocalDate;

public class SearchDto {

    private final LocalDate startDate;
    private final LocalDate endDate;
    private final String category;
    private final String search;

    public SearchDto(LocalDate startDate, LocalDate endDate, String category, String search) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.category = category;
        this.search = search;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public String getCategory() {
        return category;
    }

    public String getSearch() {
        return search;
    }

    public boolean isNull() {
        return startDate == null && endDate == null && category == null && search == null;
    }
}
