package com.study.repository;

import com.study.dto.board.BoardCreateDto;
import com.study.dto.board.BoardDetailDto;
import com.study.dto.board.BoardModifyDto;
import com.study.dto.board.BoardSearchDto;
import com.study.validator.SearchDto;

import java.util.List;

public interface BoardRepository {

    Long save(BoardCreateDto boardDto);

    List<BoardSearchDto> findPaging(int offset, int limit, SearchDto searchDto);

    Integer findCountBySearchDto(SearchDto searchDto);

    Integer countAll();

    BoardDetailDto findDetailByIndex(Long index);

    void updateViews(int views, Long boardId);

    String findPasswordById(Long boardId);

    void modifyBoard(BoardModifyDto boardModifyDto);

    void delete(Long boardId);

    List<String> findCategories();

}
