package com.aya.quizservice.util;

import com.aya.quizservice.model.dto.QuizOutputDto;
import com.aya.quizservice.model.entity.Quiz;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface QuizMapper {
    QuizMapper INSTANCE = Mappers.getMapper(QuizMapper.class);

    QuizOutputDto fromEntityToDto(Quiz quiz);
}
