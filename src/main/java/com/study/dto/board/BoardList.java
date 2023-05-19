package com.study.dto.board;

import java.util.List;

public class BoardList {

    private int count;
    private List<BoardSearchDto> boardSearchDtoList;

    public BoardList() {
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public List<BoardSearchDto> getBoardSearchDtoList() {
        return boardSearchDtoList;
    }

    public void setBoardSearchDtoList(List<BoardSearchDto> boardSearchDtoList) {
        this.boardSearchDtoList = boardSearchDtoList;
    }
}
