package classroom.controller;

import classroom.pojo.ClassroomDetail;
import classroom.pojo.ClassroomDetailExample;
import classroom.service.ClassRoomService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by ${tianlin} on 2018-01-07.
 */
@Controller
@RequestMapping("/classroom")
public class ClassRoomController {
    @Autowired
    ClassRoomService classRoomService;

    @RequestMapping("")
    public String index(){
        return "home";
    }

    @ResponseBody
    @RequestMapping("/allList")
    public List<ClassroomDetail> allList(@RequestBody String params){
        JSONObject jo=JSONObject.parseObject(params);
        List<String> buildingNames = JSON.parseArray(jo.getString("buildingName"),String.class);
        String datetime = (String)jo.get("datetime");
        List<ClassroomDetail> list = classRoomService.list(buildingNames,datetime);
        return list;
    }

    @ResponseBody
    @RequestMapping("/mergeList")
    public List<ClassroomDetail> mergeList(@RequestBody String params){
        JSONObject jo=JSONObject.parseObject(params);
        List<String> buildingNames = JSON.parseArray(jo.getString("buildingName"),String.class);
        String datetime = (String)jo.get("datetime");
        List<ClassroomDetail> list = classRoomService.list(buildingNames,datetime);
        List<ClassroomDetail> nList = new ArrayList<ClassroomDetail>();
        for(ClassroomDetail classroomDetail : list){
            ClassroomDetail temp = new ClassroomDetail();
            temp.setBuildingName(classroomDetail.getBuildingName());
            temp.setClassroom(classroomDetail.getClassroom());
            temp.setDatetime(classroomDetail.getDatetime());
            if("空闲".equals(classroomDetail.getFirst()) && "空闲".equals(classroomDetail.getSecond())){
                temp.setFirst("空闲");
            }else{
                temp.setFirst("有课");
            }

            if("空闲".equals(classroomDetail.getThird()) && "空闲".equals(classroomDetail.getFourth())){
                temp.setSecond("空闲");
            }else{
                temp.setSecond("有课");
            }

            if("空闲".equals(classroomDetail.getFifth()) && "空闲".equals(classroomDetail.getSixth())){
                temp.setThird("空闲");
            }else{
                temp.setThird("有课");
            }

            if("空闲".equals(classroomDetail.getSeventh()) && "空闲".equals(classroomDetail.getEighth())){
                temp.setFourth("空闲");
            }else{
                temp.setFourth("有课");
            }

            if("空闲".equals(classroomDetail.getNinth()) && "空闲".equals(classroomDetail.getTenth())){
                temp.setFifth("空闲");
            }else{
                temp.setFifth("有课");
            }

            if("空闲".equals(classroomDetail.getEleventh()) && "空闲".equals(classroomDetail.getTwelfth())){
                temp.setSixth("空闲");
            }else{
                temp.setSixth("有课");
            }

            nList.add(temp);
        }
        return nList;
    }

    @RequestMapping("addList")
    public String addList(Model model,int year){
        classRoomService.delete(year);
        classRoomService.addList(year);
        return "admin/main";
    }

    @RequestMapping("admin_classroom")
    public String admin_classroom(Model model){
        return "admin/main";
    }
}
