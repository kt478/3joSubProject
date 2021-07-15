package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import com.google.gson.Gson;

import dao.CosDAO;
import dao.DogDAO;
import dao.PersonDAO;
import dao.PlannerDAO;
import dto.CosDTO;
import dto.DogDTO;
import dto.PersonDTO;
import dto.PlannerDTO;
import dto.WeatherDTO;

@WebServlet("*.planner")
public class PlannerController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         request.setCharacterEncoding("utf-8");

         String requestURI = request.getRequestURI(); // 프로젝트명 + 파일명,주소명
         String ctxPath = request.getContextPath(); // 프로젝트명
         String url = requestURI.substring(ctxPath.length()); // (프로젝트명 + 파일명,주소명) - 프로젝트명 = 파일명, 주소명 
         System.out.println(url);
         
         try {
        	 PersonDAO mdao = PersonDAO.getInstance();
        	 PlannerDAO Pdao = PlannerDAO.getInstance();
        	 CosDAO cdao = CosDAO.getInstance();
        	 DogDAO ddao = DogDAO.getInstance();
        	 WeatherDTO wtdto = new WeatherDTO();
            
            if(url.contentEquals("/history.planner")) { // 히스토리가지고 이동
               PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
               
               List<PlannerDTO> history = Pdao.history(dto.getId()); 
               if(history != null) {
                  request.setAttribute("history", history); // 히스토리
                  request.getRequestDispatcher("Mypage/walkPlanner.jsp").forward(request, response);
               }else {
                  response.sendRedirect("Mypage/walkPlanner.jsp");
               }
            }else if(url.contentEquals("/p_info.planner")) { // 히스토리 사람정보
               String other_id = request.getParameter("otherId");
               
               PersonDTO person = mdao.information(other_id); // 이름, 나이, 성별
               
               response.setContentType("text/html;charset=utf-8");
               Gson g = new Gson();
               
               String result = g.toJson(person);
               response.getWriter().append(result); 

            }else if(url.contentEquals("/d_info.planner")) { // 히스토리 강아지정보
               String other_id = request.getParameter("otherId");
               
               DogDTO dog = ddao.information(other_id);
               
               response.setContentType("text/html;charset=utf-8");
               Gson g = new Gson();
               
               String result = g.toJson(dog); 
               response.getWriter().append(result); 
               
            }else if(url.contentEquals("/add.planner")) { // 혼자 일정추가
               PersonDTO dto = (PersonDTO)request.getSession().getAttribute("login");
               String id = dto.getId();
               
               String getStart = request.getParameter("start");
               String start_date = getStart.substring(0,10);
                String start_time = getStart.substring(11,16);
               String start =  start_date + " " + start_time;
               
                String getEnd = request.getParameter("end");
                String end_date = getEnd.substring(0,10);
                String end_time = getEnd.substring(11,16);
                String end = end_date + " " + end_time;
             
                String local = request.getParameter("local");
                String place_name = request.getParameter("place_name");

                String pet_feature = ddao.getFeature(id);
                System.out.println(pet_feature);
                CosDTO cdto = cdao.getAllAddress(place_name);
                
                PlannerDTO Pdto = new PlannerDTO(0, id, pet_feature, local, place_name, start, end, 
                      cdto.getPostcode(), cdto.getAddress1(), null, null);

                int result = Pdao.aloneAddPlan(Pdto);
                
                response.setContentType("text/html;charset=utf-8");
               if(result>0) {
                  response.getWriter().append("1");
               }else {
                  response.getWriter().append("0");
               }
               
            }else if(url.contentEquals("/update.planner")) { // 일정수정
               int seq = Integer.parseInt(request.getParameter("seq"));
               String title = request.getParameter("title");
               String start = request.getParameter("start");
               String end = request.getParameter("end");

               System.out.println(seq + ", " + title + ", " + start + ", " + end);
               
               int result = Pdao.update(seq, start, end);
               if(result>0) {
                  response.getWriter().append("1");
               }
            }else if(url.contentEquals("/delete.planner")) { // 일정수정
               int seq = Integer.parseInt(request.getParameter("seq"));
               
               System.out.println(seq);
               
               int result = Pdao.delete(seq);
               if(result>0) {
                  response.getWriter().append("1");
               }
            }else if(url.contentEquals("/weather.planner")) { 

				String choosedate = request.getParameter("date");
				Date d = new Date(System.currentTimeMillis());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); 

				String sysdate = sdf.format(d);  
				int result = Integer.parseInt(choosedate) - Integer.parseInt(sysdate);
				System.out.println(choosedate + " : " + sysdate);
				System.out.println(result);

				String wtUrl = "https://search.naver.com/search.naver?query=%EB%82%A0%EC%94%A8";
				Document weatherPage = Jsoup.connect(wtUrl).get();
				Document doc = null; 
				Elements get_text;
				Elements get_dust;
				Elements get_maxTemper;
				Elements get_minTemper;

				if(result == 0) {
					get_text =  weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.today_area._mainTabContent > div.main_info > div > ul > li:nth-child(1) > p");
					get_dust = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.today_area._mainTabContent > div.sub_info > div > dl > dd:nth-child(2) > span.num");            
					get_maxTemper = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(1) > dl > dd > span:nth-child(3)").select("span");
					get_minTemper = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(1) > dl > dd > span:nth-child(1)").select("span");

					Pattern p1 = Pattern.compile("(.+?),");
					Matcher m1 = p1.matcher(get_text.text());

					while(m1.find()) {
						System.out.println(m1.group(1));
						wtdto.setText(m1.group(1));
					}

					Pattern p2 = Pattern.compile("(.+?)㎍/㎥");
					Matcher m2 = p2.matcher(get_dust.text());
					while(m2.find()) {
						int num = Integer.parseInt(m2.group(1));
						System.out.println(num);
						if(num<=30) {
							wtdto.setDust(get_dust.text() + " 좋음");
						}else if(num<=80) {
							wtdto.setDust(get_dust.text() + " 보통");
						}else if(num<=150) {
							wtdto.setDust(get_dust.text() + " 나쁨");
						}else {
							wtdto.setDust(get_dust.text() + " 매우나쁨");
						}
					}
					wtdto.setMinTemper(get_minTemper.text());
					wtdto.setMaxTemper(get_maxTemper.text());

				} else if(result == 1) { // 내일
					get_text = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div:nth-child(4) > div:nth-child(2) > div > ul > li:nth-child(1) > p"); 
					get_dust = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.today_area._mainTabContent > div.sub_info > div > dl > dd:nth-child(2)");
					get_maxTemper = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(2) > dl > dd > span:nth-child(3)"); 
					get_minTemper = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(2) > dl > dd > span:nth-child(1)");

					wtdto.setText(get_text.text());
					wtdto.setDust(get_dust.text());
					wtdto.setMinTemper(get_minTemper.text());
					wtdto.setMaxTemper(get_maxTemper.text());

				}else if(result == 2) { // 모래 
					get_text = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.tomorrow_area.day_after._mainTabContent > div:nth-child(2) > div > ul > li:nth-child(1) > p"); 
					get_dust = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.tomorrow_area.day_after._mainTabContent > div:nth-child(2) > div > ul > li:nth-child(2) > div > span > span"); 
					get_maxTemper = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(3) > dl > dd > span:nth-child(3)"); 
					get_minTemper = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(3) > dl > dd > span:nth-child(1)");

					wtdto.setText(get_text.text());
					wtdto.setDust(get_dust.text());
					wtdto.setMinTemper(get_minTemper.text());
					wtdto.setMaxTemper(get_maxTemper.text());

				}else if(result == 3) { // 3일뒤
					get_text = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(4) > span.point_time.morning > span.rain_rate > span.num"); 
					get_maxTemper = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(4) > dl > dd > span:nth-child(3)");
					get_minTemper = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(4) > dl > dd > span:nth-child(1)");

					int percent = Integer.parseInt(get_text.text());
					String text = weatherPage.html();

					if(percent == 0) {
						wtdto.setText("맑음");
					}else if(percent <= 30) {
						wtdto.setText("구름많음");
					}else if(percent <= 60) {
						wtdto.setText("흐림");
					}else {
						wtdto.setText("비");
					}
					wtdto.setDust(null);
					wtdto.setMinTemper(get_minTemper.text());
					wtdto.setMaxTemper(get_maxTemper.text());      

				}else if(result == 4) { // 4일뒤 
					get_text = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(5) > span.point_time.morning > span.rain_rate > span.num"); 
					get_maxTemper = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(5) > dl > dd > span:nth-child(3)"); 
					get_minTemper = weatherPage.select("#main_pack > section.sc_new.cs_weather._weather > div > div.api_cs_wrap > div.weather_box > div.weather_area._mainArea > div.table_info.weekly._weeklyWeather > ul:nth-child(2) > li:nth-child(5) > dl > dd > span:nth-child(1)");

					int percent = Integer.parseInt(get_text.text());
					if(percent == 0) {
						wtdto.setText("맑음");
					}else if(percent <= 30) {
						wtdto.setText("구름많음");
					}else if(percent <= 60) {
						wtdto.setText("흐림");
					}else {
						wtdto.setText("비");
					}
					wtdto.setDust(null);
					wtdto.setMinTemper(get_minTemper.text());
					wtdto.setMaxTemper(get_maxTemper.text());   

				}else { // 그 이후
					wtdto.setText(null);
					wtdto.setDust(null);
					wtdto.setMinTemper(null);
					wtdto.setMaxTemper(null);   
				}
				response.setContentType("text/html;charset=utf-8");

				Gson g = new Gson();

				List<WeatherDTO> list = new ArrayList<>();
				list.add(wtdto);
				System.out.println(wtdto.getText() + " : " + wtdto.getDust() + " : " + wtdto.getMinTemper() + " : " + wtdto.getMaxTemper());
				String weather = g.toJson(list);
				response.getWriter().append(weather);

			}
         }catch(Exception e) {
        	 e.printStackTrace();
        	 response.sendRedirect("error1.jsp");
         }
      }


   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}