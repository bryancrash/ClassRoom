package classroom.util;

import classroom.exception.RuleException;
import classroom.pojo.ClassroomDetail;
import classroom.pojo.Rule;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by ${tianlin} on 2017-12-10.
 */
public class SpiderUtil {
    public static List<ClassroomDetail> extract(Calendar curDateStr,int year){
        String ulr1 = "http://www.cugb.edu.cn/classroomList.action";
        String url2 = "http://www.cugb.edu.cn/listClassroom.action";
        Rule rule = new Rule(ulr1, new String[] {}, new String[] {}, "name", Rule.CLASS, Rule.GET);
        List<String> buildingNames = getBuildingName(rule);
        String[] timePeriods = {"上午","下午","晚上"};

        SimpleDateFormat sdf1 = new SimpleDateFormat("yy-MM-dd");
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
        Calendar nowDate = Calendar.getInstance();

        List<ClassroomDetail> datas=new ArrayList<ClassroomDetail>();
            for (String buildingName : buildingNames) {
                Rule rule0 = new Rule(url2, new String[] {"curDateStr","building","timePeriod","curDate"},
                        new String[] {sdf2.format(curDateStr.getTime()),buildingName,timePeriods[0],sdf1.format(nowDate.getTime())},
                        "classroom_section", Rule.CLASS, Rule.GET);
                Rule rule1 = new Rule(url2, new String[] {"curDateStr","building","timePeriod","curDate"},
                        new String[] {sdf2.format(curDateStr.getTime()),buildingName,timePeriods[1],sdf1.format(nowDate.getTime())},
                        "classroom_section", Rule.CLASS, Rule.GET);
                Rule rule2 = new Rule(url2, new String[] {"curDateStr","building","timePeriod","curDate"},
                        new String[] {sdf2.format(curDateStr.getTime()),buildingName,timePeriods[2],sdf1.format(nowDate.getTime())},
                        "classroom_section", Rule.CLASS, Rule.GET);

                Elements results1 = getReuslt(rule0);
                Elements results2 = getReuslt(rule1);
                Elements results3 = getReuslt(rule2);

                List<ClassroomDetail> list = unionResult(results1,results2,results3,buildingName,sdf2.format(curDateStr.getTime()));
                datas.addAll(list);
            }
        return datas;
    }

    private static List<ClassroomDetail> unionResult(Elements results1, Elements results2, Elements results3,String buildingName,String curDateStr) {
        int size1 = results1.size(), size2 = results2.size(), size3 = results3.size();
        List<ClassroomDetail> datas = new ArrayList<ClassroomDetail>();

        for (int i = 1; i < size1;i++) {
            Element result = results1.get(i);
            ClassroomDetail classroomDetail = new ClassroomDetail();
            classroomDetail.setBuildingName(buildingName);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = null;
            try {
                date = sdf.parse(curDateStr);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            classroomDetail.setDatetime(date);
            classroomDetail.setClassroom(getRoomUtil(buildingName,result.getElementsByClass("room").text()));

            Elements srcs = result.select("img[src]");
            classroomDetail.setFirst(getSubUtil(srcs.get(0)));
            classroomDetail.setSecond(getSubUtil(srcs.get(1)));
            classroomDetail.setThird(getSubUtil(srcs.get(2)));
            classroomDetail.setFourth(getSubUtil(srcs.get(3)));

            datas.add(classroomDetail);
        }

        for (int i = 1; i < size2;i++) {
            Element result = results2.get(i);
            ClassroomDetail classroomDetail = datas.get(i-1);

            Elements srcs = result.select("img[src]");
            classroomDetail.setFifth(getSubUtil(srcs.get(0)));
            classroomDetail.setSixth(getSubUtil(srcs.get(1)));
            classroomDetail.setSeventh(getSubUtil(srcs.get(2)));
            classroomDetail.setEighth(getSubUtil(srcs.get(3)));
        }

        for (int i = 1; i < size3;i++) {
            Element result = results3.get(i);
            ClassroomDetail classroomDetail = datas.get(i-1);

            Elements srcs = result.select("img[src]");
            classroomDetail.setNinth(getSubUtil(srcs.get(0)));
            classroomDetail.setTenth(getSubUtil(srcs.get(1)));
            classroomDetail.setEleventh(getSubUtil(srcs.get(2)));
            classroomDetail.setTwelfth(getSubUtil(srcs.get(3)));
        }
        return datas;
    }

    private static Elements getReuslt(Rule rule) {
        Elements results = new Elements();
        try {
            String url = rule.getUrl();
            String[] params = rule.getParams();
            String[] values = rule.getValues();
            String resultTagName = rule.getResultTagName();
            int type = rule.getType();
            int requestType = rule.getRequestMoethod();
            Connection conn = Jsoup.connect(url);
            conn.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36");
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    conn.data(params[i], values[i]);
                }
            }
            //设置请求参数
            Document doc = null;
            switch (requestType) {
                case Rule.GET:
                    doc = conn.timeout(100000).ignoreContentType(true).get();
                    break;
                case Rule.POST:
                    doc = conn.timeout(100000).ignoreContentType(true).post();
                    break;
            }

            switch (type) {
                case Rule.CLASS:
                    results = doc.getElementsByClass(resultTagName);
                    break;
                case Rule.ID:
                    Element result = doc.getElementById(resultTagName);
                    results.add(result);
                    break;
                case Rule.SELECTION:
                    results = doc.select(resultTagName);
                    break;
                default:
                    //当resultTagName为空时默认去body标签
                    if (resultTagName == null) {
                        results = doc.getElementsByTag("body");
                    }
            }
        }catch (IOException e){
            e.printStackTrace();
        }
        return results;
    }

    public static List<String> getBuildingName(Rule rule){
        List<String> datas = new ArrayList<String>();
        try{
            String url=rule.getUrl();
            String[] params=rule.getParams();
            String[] values=rule.getValues();
            String resultTagName=rule.getResultTagName();
            int type=rule.getType();
            int requestType=rule.getRequestMoethod();
            Connection conn= Jsoup.connect(url);
            conn.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36");
            if(params!=null){
                for(int i=0;i<params.length;i++){
                    conn.data(params[i],values[i]);
                }
            }

            //设置请求参数
            Document doc=null;
            switch (requestType){
                case Rule.GET:
                    doc=conn.timeout(100000).ignoreContentType(true).get();
                    break;
                case Rule.POST:
                    doc=conn.timeout(100000).ignoreContentType(true).post();
                    break;
            }

            Elements results=new Elements();
            switch (type){
                case Rule.CLASS:
                    results=doc.getElementsByClass(resultTagName);
                    break;
                case Rule.ID:
                    Element result = doc.getElementById(resultTagName);
                    results.add(result);
                    break;
                case Rule.SELECTION:
                    results = doc.select(resultTagName);
                    break;
                default:
                    //当resultTagName为空时默认去body标签
                    if (resultTagName==null)
                    {
                        results = doc.getElementsByTag("body");
                    }
            }
            for (Element result : results) {
                datas.add(result.select("a").get(0).text());
            }
        }catch (IOException e){
            e.printStackTrace();
        }
        return datas;
    }

    public static String getSubUtil(Element element){
        String str = element.attr("src");
        String rgex = "images/classroom-(.*?).gif";
        String result = "";
        Pattern pattern = Pattern.compile(rgex);
        Matcher m = pattern.matcher(str);
        while(m.find()){
            if("inuse".equals(m.group(1))){
                result = "有课";
            }else if("free".equals(m.group(1))){
                result = "空闲";
            }
        }
        return result;
    }

    public static String getRoomUtil(String budingName,String room){
        String rgex = budingName;
        Pattern pattern = Pattern.compile(rgex);
        Matcher m = pattern.matcher(room);
        while (m.find()){
            return  room.replace(budingName,"");
        }
        return room;
    }
}
