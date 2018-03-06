package classroom.service.impl;

import classroom.mapper.ClassroomDetailMapper;
import classroom.pojo.ClassroomDetail;
import classroom.pojo.ClassroomDetailExample;
import classroom.service.ClassRoomService;
import classroom.util.SpiderUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by ${tianlin} on 2018-01-07.
 */
@Service
public class ClassRoomServiceImpl implements ClassRoomService {

    @Autowired
    ClassroomDetailMapper classroomDetailMapper;

    public List<ClassroomDetail> list(List<String> buildingNames,String datetime) {
        ClassroomDetailExample example = new ClassroomDetailExample();
        ClassroomDetailExample.Criteria criteria = example.createCriteria();
        if(buildingNames != null){
            criteria.andBuildingNameIn(buildingNames);
        }
        if(!"".equals(datetime)){
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date date=sdf.parse(datetime);
                criteria.andDatetimeEqualTo(date);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return classroomDetailMapper.selectByExample(example);
    }

    public void addList(int year) {
        ClassroomDetailExample example = new ClassroomDetailExample();
        classroomDetailMapper.deleteByExample(example);

        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");

        Calendar startDate = Calendar.getInstance();
        startDate.set(Calendar.YEAR,year);
        startDate.set(Calendar.MONTH,0);
        startDate.set(Calendar.DAY_OF_MONTH,1);

        Calendar endDate = Calendar.getInstance();
        endDate.set(Calendar.YEAR,year);
        endDate.set(Calendar.MONTH,11);
        endDate.set(Calendar.DAY_OF_MONTH,31);

        for (Calendar curDateStr = startDate; curDateStr.before(endDate) || curDateStr.equals(endDate); curDateStr.add(Calendar.DATE, 1)) {
            List<ClassroomDetail> list = SpiderUtil.extract(curDateStr, year);
            classroomDetailMapper.insertList(list);
        }
    }

    public void delete(int year){
        classroomDetailMapper.deleteByYear(String.valueOf(year)+"%");
    }
}
