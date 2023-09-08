package dto;

public class ReviewPagingDTO {
	String movie_id, sort_type;
	int start, end;
	
	public String getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}
	public String getSort_type() {
		return sort_type;
	}
	public void setSort_type(String sort_type) {
		this.sort_type = sort_type;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}

}
