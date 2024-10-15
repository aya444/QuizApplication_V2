package com.aya.quizservice.service.impl;

import com.aya.quizservice.exception.InvalidQuizDataException;
import com.aya.quizservice.exception.QuizNotFoundException;
import com.aya.quizservice.feign.QuizInterface;
import com.aya.quizservice.model.dto.QuestionOutputDto;
import com.aya.quizservice.model.dto.QuizOutputDto;
import com.aya.quizservice.model.entity.Quiz;
import com.aya.quizservice.model.entity.Response;
import com.aya.quizservice.repository.QuizRepository;
import com.aya.quizservice.service.QuizService;
import com.aya.quizservice.util.QuizMapper;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class QuizServiceImpl implements QuizService {

    @Autowired
    private QuizRepository quizRepository;

    @Autowired
    private QuizInterface quizInterface;

    private final QuizMapper questionMapper = QuizMapper.INSTANCE;

    @Override
    public void createQuiz(String category, Integer numOfQuestions, String title) {
        List<Integer> questionIds = quizInterface.getQuestionsForQuiz(category, numOfQuestions).getBody();
        quizRepository.save(Quiz.builder()
                .title(title)
                .questionsIds(questionIds)
                .build());
    }

    @Override
    public List<QuizOutputDto> getAllQuizzes() {
        List<Quiz> quizList = quizRepository.findAll();
        if (quizList.isEmpty()) {
            throw new QuizNotFoundException("No quizzes found!");
        } else {
            return quizList.stream()
                    .map(questionMapper::fromEntityToDto)
                    .collect(Collectors.toList());
        }
    }

    @Override
    public List<QuestionOutputDto> getQuizQuestions(Integer id) {
        Quiz quiz = quizRepository.findById(id).orElseThrow(() -> new QuizNotFoundException("Quiz Id not found!"));
        List<Integer> questionIdsList = quiz.getQuestionsIds();
        List<QuestionOutputDto> questionList = quizInterface.getQuestionsById(questionIdsList).getBody();
        return questionList;
    }

    @Override
    public String calculateResults(Integer id, @Valid List<Response> responseList) {
        Quiz quiz = quizRepository.findById(id).orElseThrow(() -> new QuizNotFoundException("Quiz Id not found!"));
        List<Integer> questionIds = quiz.getQuestionsIds();
        if (responseList.size() != questionIds.size()) {
            throw new InvalidQuizDataException("Mismatch between the number of responses and questions!");
        }
        for (Response response : responseList) {
            if (!questionIds.contains(response.getId())) {
                throw new InvalidQuizDataException("Response contains an invalid question!");
            }
        }
        return quizInterface.getResult(responseList).getBody();
    }
}
