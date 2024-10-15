package com.aya.questionservice.service.impl;

import com.aya.questionservice.exception.InvalidQuestionDataException;
import com.aya.questionservice.exception.QuestionNotFoundException;
import com.aya.questionservice.exception.ResultsNotFoundException;
import com.aya.questionservice.model.dto.QuestionInputDto;
import com.aya.questionservice.model.dto.QuestionOutputDto;
import com.aya.questionservice.model.entity.Question;
import com.aya.questionservice.model.entity.Response;
import com.aya.questionservice.repository.QuestionRepository;
import com.aya.questionservice.service.QuestionService;
import com.aya.questionservice.util.QuestionMapper;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionRepository questionRepo;

    private final QuestionMapper questionMapper = QuestionMapper.INSTANCE;

    @Override
    public QuestionOutputDto createQuestion(@Valid QuestionInputDto questionInputDto) {
        Optional.ofNullable(questionInputDto).orElseThrow(() -> new InvalidQuestionDataException("Question data cannot be null!"));
        Question questionEntity = questionMapper.fromDtoToEntity(questionInputDto);
        Question savedQuestionEntity = questionRepo.save(questionEntity);
        return questionMapper.fromEntityToDto(savedQuestionEntity);
    }

    @Override
    public QuestionOutputDto editQuestion(Integer id, @Valid QuestionInputDto updatedQuestionInputDto) {
        Optional.ofNullable(updatedQuestionInputDto).orElseThrow(() -> new InvalidQuestionDataException("Updated question data cannot be null!"));
        return questionRepo.findById(id)
                .map(question -> {
                    questionMapper.updateEntityFromDto(question, updatedQuestionInputDto);
                    Question updatedQuestion = questionRepo.save(question);
                    return questionMapper.fromEntityToDto(updatedQuestion);
                })
                .orElseThrow(() -> new QuestionNotFoundException("Question Id not found!"));
    }

    @Override
    public void deleteQuestion(Integer id) {
        if (questionRepo.existsById(id)) {
            questionRepo.deleteById(id);
        } else {
            throw new QuestionNotFoundException("Question Id not found!");
        }
    }

//    @Override
//    public List<QuestionOutputDto> getAllQuestions() {
//        List<Question> questionList = questionRepo.findAllQuestionsSorted();
//        return questionList.stream()
//                .map(questionMapper::fromEntityToDto)
//                .collect(Collectors.toList());
//    }

    @Override
    public List<QuestionInputDto> getAllQuestions() {
        List<Question> questionList = questionRepo.findAllQuestionsSorted();
        return questionList.stream()
                .map(questionMapper::fromEntityToInputDto)
                .collect(Collectors.toList());
    }

    @Override
    public List<QuestionOutputDto> getQuestionsByCategory(String category) {
        List<Question> foundQuestionList = questionRepo.findByCategory(category);
        if (foundQuestionList.isEmpty())
            throw new ResultsNotFoundException("No questions found for category: " + category);
        return foundQuestionList.stream()
                .map(questionMapper::fromEntityToDto)
                .collect(Collectors.toList());
    }

    @Override
    public QuestionInputDto getQuestionById(Integer id) {
        Question question = questionRepo.findById(id).orElseThrow(() -> new QuestionNotFoundException("No questions found for id: " + id));
        return questionMapper.fromEntityToInputDto(question);
    }

    @Override
    public List<QuestionOutputDto> getQuestionsById(List<Integer> questionIds) {
        return questionIds.stream()
                .map(id -> questionRepo.findById(id)
                        .orElseThrow(() -> new QuestionNotFoundException("Question with id " + id + " not found")))
                .map(questionMapper::fromEntityToDto)
                .collect(Collectors.toList());
    }

    @Override
    public List<Integer> getQuestionsForQuiz(String category, Integer numOfQuestions) {
        if (numOfQuestions <= 0) {
            throw new InvalidQuestionDataException("Number of questions must be greater than 0!");
        }
        List<Integer> foundRandomQuestionsIdsForCategory = questionRepo.findRandomQuestionsByCategory(category, numOfQuestions);
        if (foundRandomQuestionsIdsForCategory.isEmpty()) {
            throw new QuestionNotFoundException("No questions found for category: " + category);
        }

        return foundRandomQuestionsIdsForCategory;
    }

    @Override
    public String calculateResults(List<Response> responseList) {
        Integer result = 0;
        Integer numOfQuestions = responseList.size();

        for (Response response : responseList) {
            Question question = questionRepo.findById(response.getId())
                    .orElseThrow(() -> new QuestionNotFoundException("Question with id " + response.getId() + " not found"));

            if (question.getRightAnswer().equals(response.getResponse())) {
                result++;
            }
        }
        return "" + result + "/" + numOfQuestions + "";
    }
}

