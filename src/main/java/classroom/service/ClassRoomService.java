package classroom.service;

import classroom.pojo.ClassroomDetail;

import java.util.List;

/**
 * Created by ${tianlin} on 2018-01-07.
 */
public interface ClassRoomService {
    /**
     * 查询列表
     * @return
     * @param buildingNames
     * @param datetime
     */
    List<ClassroomDetail> list(List<String> buildingNames, String datetime);

    /**
     * 批量插入
     * @param year
     */
    void addList(int year);

    void delete(int year);
}
