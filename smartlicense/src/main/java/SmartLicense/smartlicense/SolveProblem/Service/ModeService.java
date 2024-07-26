package SmartLicense.smartlicense.SolveProblem.Service;

import SmartLicense.smartlicense.SolveProblem.Dao.ModeDao;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.parsing.Problem;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ModeService {

    @Autowired
    ModeDao modeDao;

    public HashMap<String, Object> testModeLoadExam(HashMap<String, Object> params) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        params.put("subject", objectMapper.readValue(params.get("subject").toString(), List.class));

        HashMap<String, Object> result = new HashMap<>();
        try{
            result.put("exam", modeDao.testModeLoadExam(params));
            System.out.println("sumTime : " + modeDao.getExamDuration(params));
            result.put("timeRemaining", modeDao.getExamDuration(params));
        } catch (Exception e) {
            result.put("exam", 0);
            result.put("timeRemaining", 0);
            e.printStackTrace();
        }

        return result;
    }

    public HashMap<String, Object> userSelectAnswer(HashMap<String, Object> params) {
        HashMap<String, Object> result = new HashMap<>();
        result.put("result", 0);
        try{
            int isSuccess = modeDao.userSelectAnswer(params);
            result.put("result", isSuccess);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public Integer storeExamRecord(HashMap<String, Object> params) {
        try{
            return modeDao.storeExamRecord(params);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public HashMap<String, Object> loadTestScore(HashMap<String, Object> params) throws JsonProcessingException {
        HashMap<String, Object> result = new HashMap<>();
        result.put("result" , 0);
        ObjectMapper objectMapper = new ObjectMapper();
        List subjects = objectMapper.readValue(params.get("subject").toString(), List.class);
        params.put("subject", subjects);
        System.out.println("params : "+ params);
        try{
            List<Object> subjectScore = new ArrayList<>();
            List<Object> subjectName = new ArrayList<>();
            List<Object> subjectQNumber = new ArrayList<>();
            List<HashMap<String, Object>> options = modeDao.getSubjectName(params);
            System.out.println("options : " + options);
            for(HashMap<String, Object> option : options) {
                System.out.println("option : " + option);
                subjectName.add(option.get("subject_number") + "과목 : " + option.get("subject_name"));
                subjectQNumber.add(option.get("question_total_count"));
            }
            for(Object subject : subjects) {
                params.put("subject", subject);
                subjectScore.add(modeDao.loadTestScore(params));
            }
            result.put("subject", subjectName);
            System.out.println("완료1");
            result.put("qnumber", subjectQNumber);
            System.out.println("완료2");
            result.put("score", subjectScore);
            System.out.println("완료3");
            result.put("remaintime", modeDao.getRemainingTime(params));
            System.out.println("완료4");
            result.put("result", 1);
            System.out.println(result);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 연습 모드 문제 로드
    public List<Map<String, Object>> practiceModeLoadExam(Map<String, Object> params) {
        return modeDao.practiceModeLoadExam(params);
    }
}