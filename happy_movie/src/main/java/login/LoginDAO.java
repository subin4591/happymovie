package login;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import dto.UserDTO;

@Repository
public class LoginDAO {
	@Autowired
	SqlSession session;
	
	// user_id로 정보 조회
	public UserDTO userOne(String user_id) {
		return session.selectOne("userOne", user_id);
	}
	
	// 회원가입
	public void insertUser(UserDTO dto) {
		session.selectOne("insertUser", dto);
	}
	
	// 회원정보 수정
	public void updateUser(UserDTO dto) {
		session.selectOne("updateUser", dto);
	}
	
	// 회원탈퇴
	public void deleteUser(String user_id) {
		session.selectOne("deleteUser", user_id);
	}
}
