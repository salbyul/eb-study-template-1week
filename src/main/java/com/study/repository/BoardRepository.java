package com.study.repository;

import com.study.dto.board.BoardCreateDto;
import com.study.dto.board.BoardDetailDto;
import com.study.dto.board.BoardSearchDto;

import java.util.List;

public interface BoardRepository {

    Long save(BoardCreateDto boardDto);

    List<BoardSearchDto> findPaging(int offset, int limit);

    Integer countAll();

    BoardDetailDto findDetailByIndex(Long index);

    void updateViews(int views, Long boardId);
}
