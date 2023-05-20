package com.study.dto.board;

import java.util.List;

public class BoardList {

    private PagingDto pagingDto;
    private List<BoardSearchDto> boardSearchDtoList;

    public PagingDto getPagingDto() {
        return pagingDto;
    }

    public void setPagingDto(PagingDto pagingDto) {
        this.pagingDto = pagingDto;
    }

    public List<BoardSearchDto> getBoardSearchDtoList() {
        return boardSearchDtoList;
    }

    public void setBoardSearchDtoList(List<BoardSearchDto> boardSearchDtoList) {
        this.boardSearchDtoList = boardSearchDtoList;
    }
}
