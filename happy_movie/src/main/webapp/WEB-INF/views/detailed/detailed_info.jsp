<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="info_contents" class="contents">
	<h1><img class="bar" src="resources/images/Bar.svg">시놉시스</h1>
	
	<c:choose>
		<c:when test="${ movie_dto.synopsis == null || movie_dto.synopsis eq '정보가 없습니다.' }">
			<p>
				따단-딴-따단-딴 ♫<br>
				전 세계를 열광시킬 올 타임 슈퍼 어드벤처의 등장!<br><br>
				
				뉴욕의 평범한 배관공 형제 '마리오'와 '루이지'는<br>
				배수관 고장으로 위기에 빠진 도시를 구하려다<br>
				미스터리한 초록색 파이프 안으로 빨려 들어가게 된다.<br><br>
				
				파이프를 통해 새로운 세상으로 차원 이동하게 된 형제.<br>
				형 '마리오'는 뛰어난 리더십을 지닌 '피치'가 통치하는 버섯왕국에 도착하지만<br>
				동생 '루이지'는 빌런 '쿠파'가 있는 다크랜드로 떨어지며 납치를 당하고<br>
				‘마리오’는 동생을 구하기 위해 '피치'와 '키노피오'의 도움을 받아 '쿠파'에 맞서기로 결심한다.<br><br>
				
				그러나 슈퍼스타로 세상을 지배하려는 그의 강력한 힘 앞에<br>
				이들은 예기치 못한 위험에 빠지게 되는데...!<br><br>
				
				동생을 구하기 위해! 세상을 지키기 위해!<br>
				'슈퍼 마리오'로 레벨업하기 위한 '마리오'의 스펙터클한 스테이지가 시작된다!<br>
			</p>
		</c:when>
		<c:otherwise>
			<p>${ movie_dto.synopsis }</p>
		</c:otherwise>
	</c:choose>
</div>