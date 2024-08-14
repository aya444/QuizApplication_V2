package com.aya.questionservice.util;

import com.aya.questionservice.model.dto.QuestionInputDto;
import com.aya.questionservice.model.dto.QuestionOutputDto;
import com.aya.questionservice.model.entity.Question;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.factory.Mappers;

@Mapper
public interface QuestionMapper {
    QuestionMapper INSTANCE = Mappers.getMapper(QuestionMapper.class);

    QuestionOutputDto fromEntityToDto(Question question);

    Question fromDtoToEntity(QuestionInputDto questionInputDto);

    @Mapping(target = "id", ignore = true)
    void updateEntityFromDto(@MappingTarget Question question, QuestionInputDto dto);
}
