package com.aya.questionservice.service;


import com.aya.questionservice.model.dto.QuestionInputDto;
import com.aya.questionservice.model.dto.QuestionOutputDto;
import com.aya.questionservice.model.entity.Response;

import java.util.List;

public interface QuestionService {
    List<QuestionOutputDto> getAllQuestions();

    List<QuestionOutputDto> getQuestionsByCategory(String category);

    QuestionOutputDto createQuestion(QuestionInputDto questionInputDto);

    QuestionOutputDto editQuestion(Integer id, QuestionInputDto updatedQuestionInputDto);

    void deleteQuestion(Integer id);

    List<Integer> getQuestionsForQuiz(String category, Integer numOfQuestions);

    List<QuestionOutputDto> getQuestionsById(List<Integer> questionIds);

    Integer calculateResults(List<Response> responseList);
}
