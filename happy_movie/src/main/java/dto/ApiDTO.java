package dto;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class ApiDTO {
	
	public int getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}

	int movie_id;
	String kor_title,eng_title;
	int release_date;
	double rating_star;
	int audiences,running_time;
	String production,genre,country,rating_age,img_url,synopsis;
	double star;
	
	ApiDTO(){}
	
	public ApiDTO(int movie_id, String kor_title, String eng_title, int release_date, double rating_star, int audiences,
			int running_time, String production, String genre, String country, String rating_age, String img_url,
			String synopsis,double star) {
		super();
		this.movie_id = movie_id;
		this.kor_title = kor_title;
		this.eng_title = eng_title;
		this.release_date = release_date;
		this.rating_star = rating_star;
		this.audiences = audiences;
		this.running_time = running_time;
		this.production = production;
		this.genre = genre;
		this.country = country;
		this.rating_age = rating_age;
		this.img_url = img_url;
		this.synopsis = synopsis;
		this.star = star;
	}

	public double getStar() {
		return star;
	}

	public void setStar(int star) {
		this.star = star;
	}

	public String getKor_title() {
		return kor_title;
	}
	public void setKor_title(String kor_title) {
		this.kor_title = kor_title;
	}
	public String getEng_title() {
		return eng_title;
	}
	public void setEng_title(String eng_title) {
		this.eng_title = eng_title;
	}
	public int getRelease_date() {
		return release_date;
	}
	public void setRelease_date(int release_date) {
		this.release_date = release_date;
	}

	public double getRating_star() {
		return rating_star;
	}

	public void setRating_star(double rating_star) {
		this.rating_star = rating_star;
	}

	public void setStar(double star) {
		this.star = star;
	}

	public int getAudiences() {
		return audiences;
	}
	public void setAudiences(int audiences) {
		this.audiences = audiences;
	}
	public int getRunning_time() {
		return running_time;
	}
	public void setRunning_time(int running_time) {
		this.running_time = running_time;
	}
	public String getProduction() {
		return production;
	}
	public void setProduction(String production) {
		this.production = production;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getRating_age() {
		return rating_age;
	}
	public void setRating_age(String rating_age) {
		this.rating_age = rating_age;
	}
	public String getImg_url() {
		return img_url;
	}
	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}
	public String getSynopsis() {
		return synopsis;
	}
	public void setSynopsis(String synopsis) {
		this.synopsis = synopsis;
	}

	@Override
	public String toString() {
		return "ApiDTO [movie_id=" + movie_id + ", kor_title=" + kor_title + ", eng_title=" + eng_title
				+ ", release_date=" + release_date + ", rating_star=" + rating_star + ", audiences=" + audiences
				+ ", running_time=" + running_time + ", production=" + production + ", genre=" + genre + ", country="
				+ country + ", rating_age=" + rating_age + ", img_url=" + img_url + ", synopsis=" + synopsis + "]";
	}
	
}
