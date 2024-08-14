package com.aya.questionservice.repository;


import com.aya.questionservice.model.entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Integer> {

    @Query("SELECT q FROM Question q ORDER BY q.id ASC ")
    List<Question> findAllQuestionsSorted();

    List<Question> findByCategory(String category);

    @Query("SELECT q.id FROM Question q WHERE q.category=:category ORDER BY RANDOM() LIMIT :numOfQuestions")
    List<Integer> findRandomQuestionsByCategory(String category, int numOfQuestions);
}
