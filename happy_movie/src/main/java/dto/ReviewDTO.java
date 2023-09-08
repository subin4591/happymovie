package dto;

public class ReviewDTO {
	int seq;
	String user_id, contents;
	int rating_star;
	String movie_id, writing_time, name, pw;
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getRating_star() {
		return rating_star;
	}
	public void setRating_star(int rating_star) {
		this.rating_star = rating_star;
	}
	public String getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}
	public String getWriting_time() {
		return writing_time;
	}
	public void setWriting_time(String writing_time) {
		this.writing_time = writing_time;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
}
