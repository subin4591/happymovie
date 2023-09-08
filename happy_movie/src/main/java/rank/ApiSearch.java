package rank;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;


public class ApiSearch {
		
	public String imgurl(String title) throws Exception {
		String clientId = "pkmvLTeLEPA0RC5iu8SS"; //애플리케이션 클라이언트 아이디
		String clientSecret = "8nXp1Im0rl"; //애플리케이션 클라이언트 시크릿
        String text = null;
        try {
            text = URLEncoder.encode(title + " 포스터", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }

        String apiURL = "https://openapi.naver.com/v1/search/image?query=" + text;    // JSON 결과
        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // XML 결과

        Map<String, String> requestHeaders = new HashMap();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = get(apiURL,requestHeaders);
        if(responseBody == null) {
        	return "resources/images/noimg.jpg";
        }
        ModelAndView mv = new ModelAndView();
        
        ObjectMapper mapper = new ObjectMapper();
    	HashMap<String,Object> result = mapper.readValue(responseBody, HashMap.class);
			
		/*System.out.println(result);*/
    	if(result == null || ((ArrayList)result.get("items")).size() == 0  || result.get("items") == null) {
    		return "resources/images/noimg.jpg";
    	}
    	
    	String resultString = ((ArrayList)result.get("items")).get(0).toString();
    	
    	Pattern pattern = Pattern.compile("link=(.*?),");
    	Matcher matcher = pattern.matcher(resultString);
    	if (matcher.find()) {
    		if(matcher.group(1).length() > 200) {
    			return "resources/images/noimg.jpg";
    		}else {
    		return matcher.group(1);
    		}
    	}
    	
		/*String responseBody2 = ((ArrayList)result.get("items")).get(0).toString();
		Pattern pattern = Pattern.compile("link=(.*?=,)");
		Matcher matcher = pattern.matcher(responseBody2);
		Thread.sleep(100);
		if (matcher.find()) {
			System.out.println(matcher.group(1));
		    return matcher.group(1);  
		}*/
    	return "resources/images/noimg.jpg";
		/*String[] parts = responseBody2.spqlit(", ");
		String link = null;
		for(String part : parts) {
		    if(part.startsWith("link=")) {
		        link = part.substring(5);  // "link=" 의 길이는 5 이므로  
		        return link;
		    }
		}
		return "resources/images/noimg.jpg";*/
    	
    }
	public String searchContent(String title) throws Exception {
		String clientId = "aufm0IPqyofeaqYAWLU1"; //애플리케이션 클라이언트 아이디
		String clientSecret = "gE9QGJnsR2"; //애플리케이션 클라이언트 시크릿

        String text = null;
        try {
			String[] parts = title.split("[-:]"); // "-" 또는 ":"를 기준으로 문자열을 분리합니다.
			String firstPart = parts[0];
            text = URLEncoder.encode(firstPart , "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }


        String apiURL = "https://openapi.naver.com/v1/search/book?query=" + text;    // JSON 결과
        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // XML 결과


        Map<String, String> requestHeaders = new HashMap();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = get(apiURL,requestHeaders);
        
        ObjectMapper mapper = new ObjectMapper();
    	HashMap<String,Object> result = mapper.readValue(responseBody, HashMap.class);
    	try {
	    	if( (int)result.get("total") == 0) {
	    		return "정보가 없습니다.";
	    	};
    	}catch(Exception e) {
    		return "정보가 없습니다.";
    	}
    	String responseBody2 = ((ArrayList)result.get("items")).get(0).toString();
    	responseBody2 = responseBody2.replaceAll("\n", " ");
    	Pattern pattern = Pattern.compile("description=(.*?)}");
    	Matcher matcher = pattern.matcher(responseBody2);
    	String description = null;
    	if (matcher.find()) {
    	    description = matcher.group(1);
    	    if(description.length()>2000) {
    	    	description = description.substring(0,2000);
    	    }
    	    return description;
    	}
    	return "정보가 없습니다.";
    }
	public String searchGrade(String title) throws Exception {
		String clientId = "gvLroCPhpHM_NKjKE44o"; //애플리케이션 클라이언트 아이디
		String clientSecret = "4Ju7qS9h2s"; //애플리케이션 클라이언트 시크릿
		
        String text = null;
        try {
            text = URLEncoder.encode(title + " 평점", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }


        String apiURL = "https://openapi.naver.com/v1/search/blog?query=" + text;    // JSON 결과
        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // XML 결과


        Map<String, String> requestHeaders = new HashMap();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = get(apiURL,requestHeaders);
        
        ObjectMapper mapper = new ObjectMapper();
    	HashMap<String,Object> result = mapper.readValue(responseBody, HashMap.class);
    	Pattern pattern = Pattern.compile("\\d\\.\\d");
    	Matcher matcher = pattern.matcher(result.toString());
    	if (matcher.find()) {
    		if(Double.parseDouble( matcher.group()) < 5) {
    			return "6.5";
    		}
    	    return matcher.group();
    	}
    	return "7.1";
    }
	
    private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }


            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 오류 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }


    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);


        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }


            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }
}
