package com.aya.questionservice.service;


import com.aya.questionservice.model.dto.QuestionInputDto;
import com.aya.questionservice.model.dto.QuestionOutputDto;
import com.aya.questionservice.model.entity.Response;

import java.util.List;

public interface QuestionService {

    QuestionOutputDto createQuestion(QuestionInputDto questionInputDto);

    QuestionOutputDto editQuestion(Integer id, QuestionInputDto updatedQuestionInputDto);

    void deleteQuestion(Integer id);

    List<QuestionInputDto> getAllQuestions();

    List<QuestionOutputDto> getQuestionsByCategory(String category);

    QuestionInputDto getQuestionById(Integer id);

    List<QuestionOutputDto> getQuestionsById(List<Integer> questionIds);

    List<Integer> getQuestionsForQuiz(String category, Integer numOfQuestions);

    String calculateResults(List<Response> responseList);
}
