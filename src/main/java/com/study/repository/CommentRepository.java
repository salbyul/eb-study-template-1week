package com.study.repository;

import com.study.dto.comment.CommentDto;
import com.study.dto.comment.CommentSaveDto;

import java.util.List;

public interface CommentRepository {

    void save(CommentSaveDto commentSaveDto);

    List<CommentDto> findByBoardId(Long boardId);
}
