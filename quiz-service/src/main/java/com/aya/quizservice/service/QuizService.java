package com.aya.quizservice.service;

import com.aya.quizservice.model.dto.QuestionOutputDto;
import com.aya.quizservice.model.dto.QuizOutputDto;
import com.aya.quizservice.model.entity.Response;

import java.util.List;

public interface QuizService {
    void createQuiz(String category, Integer numOfQuestions, String title);

    List<QuizOutputDto> getAllQuizzes();

    List<QuestionOutputDto> getQuizQuestions(Integer id);

    String calculateResults(Integer id, List<Response> responseList);
}
