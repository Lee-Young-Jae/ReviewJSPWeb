<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device=width, initial-scale=1 shrink-to-fit=no">
	<title>DBProject</title>
	<!--  부트스트랩 CSS 추가 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!--    커스텀  CSS 추가 -->
	<link rel="stylesheet" href="./css/custom.css">
	<!--  카카오 API 키값  -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7fea230a80820eb7b6d1831851de58fe&libraries=services"></script>
	<!--  카카오 API -->
	<style>
		.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
		.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
		.map_wrap {position:relative;width:100%;height:500px;}
		#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
		.bg_white {background:#fff;}
		#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
		#menu_wrap .option{text-align: center;}
		#menu_wrap .option p {margin:10px 0;}  
		#menu_wrap .option button {margin-left:5px;}
		#placesList li {list-style: none;}
		#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
		#placesList .item span {display: block;margin-top:4px;}
		#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
		#placesList .item .info{padding:10px 0 10px 55px;}
		#placesList .info .gray {color:#8a8a8a;}
		#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
		#placesList .info .tel {color:#009900;}
		#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
		#placesList .item .marker_1 {background-position: 0 -10px;}
		#placesList .item .marker_2 {background-position: 0 -56px;}
		#placesList .item .marker_3 {background-position: 0 -102px}
		#placesList .item .marker_4 {background-position: 0 -148px;}
		#placesList .item .marker_5 {background-position: 0 -194px;}
		#placesList .item .marker_6 {background-position: 0 -240px;}
		#placesList .item .marker_7 {background-position: 0 -286px;}
		#placesList .item .marker_8 {background-position: 0 -332px;}
		#placesList .item .marker_9 {background-position: 0 -378px;}
		#placesList .item .marker_10 {background-position: 0 -423px;}
		#placesList .item .marker_11 {background-position: 0 -470px;}
		#placesList .item .marker_12 {background-position: 0 -516px;}
		#placesList .item .marker_13 {background-position: 0 -562px;}
		#placesList .item .marker_14 {background-position: 0 -608px;}
		#placesList .item .marker_15 {background-position: 0 -654px;}
		#pagination {margin:10px auto;text-align: center;}
		#pagination a {display:inline-block;margin-right:10px;}
		#pagination .on {font-weight: bold; cursor: default;color:#777;}
	</style>
</head>
<body>


<%
	request.setCharacterEncoding("UTF-8");
	String foodType = "전체";
	String searchType="최신순";
	String search="";
	
	String gu = "강남구";
	String food_category="일식";
	if(request.getParameter("gu") != null) {
		gu = request.getParameter("gu");
	}
	if(request.getParameter("food_category") != null) {
		food_category = request.getParameter("food_category");
	}
	
	int pageNumber =0;
	if(request.getParameter("foodType") != null) {
		foodType = request.getParameter("foodType");
	}
	if(request.getParameter("searchType") != null) {
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null) {
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null) {
		try{
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}catch(Exception ex){
			System.out.println("Number ERR");
			ex.printStackTrace();
		}
		
	}
	
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
		
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp'");
		script.println("</script>");
		script.close();		
		return;
	}
%>

		<!-- 상단 네비바 -->
	<nav class="navbar navbar-expand-sm bg-primary navbar-dark">
		<a class="navbar-brand" href="index.jsp">Review</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class= "navbar-toggler-icon"></span> <!-- 상태바 메뉴 토글 -->
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						회원<span></span>
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID == null){
%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userRegister.jsp">회원가입</a>
						
<%
	}else if(userID != null){
%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>		
					</div>
				</li>	
				
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">평가하기</a>
				</li>
					
				
			</ul>
			
			
			
			
		</div>
	</nav>
	
	
	<section class="container mt-3">
	<h3> </h3>
	<h3>더 많은 곳을 둘러 보세요!</h3>
		<form method="get" class="form-inline mt-3">
			<select name="gu" id="gu" class="form-control mx-1 mt-2">
				<option value="강남구" <% if(gu.equals("강남구")) out.println("selected"); %>>강남구</option>
				<option value="강동구" <% if(gu.equals("강동구")) out.println("selected"); %>>강동구</option>
				<option value="강서구" <% if(gu.equals("강서구")) out.println("selected"); %>>강서구</option>
				<option value="강북구" <% if(gu.equals("강북구")) out.println("selected"); %>>강북구</option>
				<option value="관악구" <% if(gu.equals("관악구")) out.println("selected"); %>>관악구</option>
				<option value="광진구" <% if(gu.equals("광진구")) out.println("selected"); %>>광진구</option>
				<option value="구로구" <% if(gu.equals("구로구")) out.println("selected"); %>>구로구</option>
				<option value="금천구" <% if(gu.equals("금천구")) out.println("selected"); %>>금천구</option>
				<option value="노원구" <% if(gu.equals("노원구")) out.println("selected"); %>>노원구</option>
				<option value="동대문구" <% if(gu.equals("동대문구")) out.println("selected"); %>>동대문구</option>
				<option value="도봉구" <% if(gu.equals("도봉구")) out.println("selected"); %>>도봉구</option>
				<option value="마포구" <% if(gu.equals("마포구")) out.println("selected"); %>>마포구</option>
				<option value="서대문구" <% if(gu.equals("서대문구")) out.println("selected"); %>>서대문구</option>
				<option value="성동구" <% if(gu.equals("성동구")) out.println("selected"); %>>성동구</option>
				<option value="성북구" <% if(gu.equals("성북구")) out.println("selected"); %>>성북구</option>
				<option value="서초구" <% if(gu.equals("서초구")) out.println("selected"); %>>서초구</option>
				<option value="송파구" <% if(gu.equals("송파구")) out.println("selected"); %>>송파구</option>
				<option value="영등포구" <% if(gu.equals("영등포구")) out.println("selected"); %>>영등포구</option>
				<option value="용산구" <% if(gu.equals("용산구")) out.println("selected"); %>>용산구</option>
				<option value="은평구" <% if(gu.equals("은평구")) out.println("selected"); %>>은평구</option>
				<option value="종로구" <% if(gu.equals("종로구")) out.println("selected"); %>>종로구</option> 
				<option value="중구" <% if(gu.equals("중구")) out.println("selected"); %>>중구</option>
				<option value="중랑구" <% if(gu.equals("중랑구")) out.println("selected"); %>>중랑구</option>
				
				<!-- 기본적으로 모든 옵션 선택 selected 사용 -->
			</select>
			<select name="food_category" id="food_category" class="form-control mx-1 mt-2">
				<option value="한식" <% if(food_category.equals("한식")) out.println("selected"); %>>한식</option>
				<option value="양식" <% if(food_category.equals("양식")) out.println("selected"); %>>양식</option>
				<option value="중화요리" <% if(food_category.equals("중화요리")) out.println("selected"); %>>중식</option>
				<option value="일식집" <% if(food_category.equals("일식집")) out.println("selected"); %>>일식</option>
				<option value="카페" <% if(food_category.equals("카페")) out.println("selected"); %>>카페</option>
				<option value="술집" <% if(food_category.equals("술집")) out.println("selected"); %>>술집</option>
				<option value="맛집" <% if(food_category.equals("맛집")) out.println("selected"); %>>맛집</option>
			</select>
			<div>
                <form onsubmit="searchPlaces(); return false;">
                    <!--  키워드 : <input type="text" value="<%%>" id="keyword" size="15"> -->
                    <button type="submit" class="btn btn-secondary mx-1 mt-2">검색하기</button>
                 <!--  
                    <button type="submit" class="btn btn-warning mx-1 mt-2">검색하기</button>
                    <button type="submit" class="btn btn-light mx-1 mt-2">검색하기</button>
                    <button type="submit" class="btn btn-sm-green mx-1 mt-2">검색하기</button>
                    <button type="submit" class="btn btn-block-info mx-1 mt-2">검색하기2</button> 
                    -->
                </form>
            </div>
            <div class="map_wrap mt-3">
	    	<div id="map" style="width:100%;height:450px;position:relative;overflow:hidden;"></div>
	    	<div id="menu_wrap" class="bg_white">
	        <div class="option"></div>
	        <hr>
	        <ul id="placesList"></ul>
	        <div id="pagination"></div>
	    	</div>
			</div>
		</form>
	</section>
	

	
	<script>
		// 마커를 담을 배열입니다
		var markers = [];
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();  
		
		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		// 키워드로 장소를 검색합니다
		searchPlaces();
		
		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {
			
		    var gu = document.getElementById("gu").value;
		    var food_category = document.getElementById("food_category").value;
		    var keyword = gu + " " + food_category;
		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }
		
		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch( keyword, placesSearchCB); 
		}
		
		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		
		        // 정상적으로 검색이 완료됐으면
		        // 검색 목록과 마커를 표출합니다
		        displayPlaces(data);
		
		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);
		
		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
		
		        alert('검색 결과가 존재하지 않습니다.');
		        return;
		
		    } else if (status === kakao.maps.services.Status.ERROR) {
		
		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;
		
		    }
		}
		
		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {
		
		    var listEl = document.getElementById('placesList'), 
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    bounds = new kakao.maps.LatLngBounds(), 
		    listStr = '';
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
		    removeAllChildNods(listEl);
		
		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker();
		    
		    for ( var i=0; i<places.length; i++ ) {
		
		        // 마커를 생성하고 지도에 표시합니다
		        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
		
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        bounds.extend(placePosition);
		
		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        (function(marker, title) {
		            kakao.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });
		
		            kakao.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });
		
		            itemEl.onmouseover =  function () {
		                displayInfowindow(marker, title);
		            };
		
		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);
		
		        fragment.appendChild(itemEl);
		    }
		
		    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		    listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;
		
		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		    map.setBounds(bounds);
		}
		
		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {
		
		    var el = document.createElement('li'),
		    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
		                '<div class="info">' +
		                '   <h5>' + places.place_name + '</h5>';
		
		    if (places.road_address_name) {
		        itemStr += '    <span>' + places.road_address_name + '</span>' +
		                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
		    } else {
		        itemStr += '    <span>' +  places.address_name  + '</span>'; 
		    }
		                 
		      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
		                '</div>';           
		
		    el.innerHTML = itemStr;
		    el.className = 'item';
		
		    return el;
		}
		
		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
		        });
		
		    marker.setMap(map); // 지도 위에 마커를 표출합니다
		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
		
		    return marker;
		}
		
		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setMap(null);
		    }   
		    markers = [];
		}
		
		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
		    var paginationEl = document.getElementById('pagination'),
		        fragment = document.createDocumentFragment(),
		        i; 
		
		    // 기존에 추가된 페이지번호를 삭제합니다
		    while (paginationEl.hasChildNodes()) {
		        paginationEl.removeChild (paginationEl.lastChild);
		    }
		
		    for (i=1; i<=pagination.last; i++) {
		        var el = document.createElement('a');
		        el.href = "#";
		        el.innerHTML = i;
		
		        if (i===pagination.current) {
		            el.className = 'on';
		        } else {
		            el.onclick = (function(i) {
		                return function() {
		                    pagination.gotoPage(i);
		                }
		            })(i);
		        }
		
		        fragment.appendChild(el);
		    }
		    paginationEl.appendChild(fragment);
		}
		
		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
		    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
		
		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}
		
		 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {   
		    while (el.hasChildNodes()) {
		        el.removeChild (el.lastChild);
		    }
		}
</script>


	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name=foodType class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<!-- 기본적으로 모든 옵션 선택 selected 사용 -->
				<option value="한식" <% if(foodType.equals("한식")) out.println("selected"); %>>한식</option> 
				<option value="양식" <% if(foodType.equals("양식")) out.println("selected"); %>>양식</option>
				<option value="중식" <% if(foodType.equals("중식")) out.println("selected"); %>>중식</option>
				<option value="일식" <% if(foodType.equals("일식")) out.println("selected"); %>>일식</option>
				<option value="기타" <% if(foodType.equals("기타")) out.println("selected"); %>>기타</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순">최신순</option>
				<option value="추천많은순" <% if(searchType.equals("추천많은순")) out.println("selected"); %>>최다추천순</option>
				<option value="평점높은순" <% if(searchType.equals("평점높은순")) out.println("selected"); %>>평점높은순</option>
				<option value="평점낮은순" <% if(searchType.equals("평점낮은순")) out.println("selected"); %>>평점낮은순</option>
				<option value="회원후기찾기" <% if(searchType.equals("회원후기찾기")) out.println("selected"); %>>회원후기찾기</option>
				<option value="포토후기만" <% if(searchType.equals("포토후기만")) out.println("selected"); %>>포토후기만</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2 col-10" placeholder="내용을 입력하세요.">
			<button type="submit" class="btn btn-outline-info mx-1 mt-2">검색</button>
			<!-- 등록양식 -->
			<a class="btn btn-outline-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">후기쓰기</a>
		</form>
<%
	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(foodType, searchType, search, pageNumber);
	if (evaluationList != null){
		for(int i=0; i< evaluationList.size(); i++){
			if(i == 5){
				break;
			}
			EvaluationDTO evaluation = evaluationList.get(i);
%>
		<div class="card bg-light mt-3"> <!-- 위쪽으로 3만큼 여백 -->
			<div class="card-header bg-light">
				
					<div class="row">
					<div class="col-8 text-left" style="font-weight: bold;"><%=evaluation.getshopName()%> / <span style="color:brown; font-weight: bold;">(<%=evaluation.getShopLocation()%>)</span> / <span style="color:navy; font-weight: bold;">(<%=evaluation.getFoodType()%>)</span>
					/ <span style="color:gray; font-weight: bold;"><%=evaluation.getUserID()%></span>
					</div>
				
						<span class="col-4 text-right" style="color: red;">
						<% 
						if( evaluation.getTotalScore().equals("5")){
						%>
						최고예요 ★★★★★
						<%
						}else if(  evaluation.getTotalScore().equals("4")) {
						%>
						좋아요 ★★★★
						<%
						}else if(  evaluation.getTotalScore().equals("3")) {
						%>
						보통이에요 ★★★
						<%
						}else if(  evaluation.getTotalScore().equals("2")) {
						%>
						조금 아쉬워요 ★★
						<%
						}else{
						%>
						별로예요 ★
						<%
						}
						%>
						</span>
					
				
				</div>
				
			</div>
			<div class="card-body">
				<h5 class="card-title; mx-3;">
					<%=evaluation.getTitle()%>
				</h5>&nbsp;
				<p class="card-text"><%=evaluation.getContent()%></p>
				<div class="row">
				
					<div class="text-left">
						
						<%if(evaluation.getLikeCount()!=0){ %>&nbsp;
							<span style="color: green;">
							<%= evaluation.getLikeCount()%>명의 사용자가 이 평가를 유익하다고 생각해요.👍🏻
							</span>
						<%}else{%>
							&nbsp;<span style="color: silver;"> 정보가 유익했나요? 도움이 되셨다면 추천을 눌러주세요. 👉
							</span>
						<%}%>
					</div>
					<div class="col-12 text-right">
						<a onclick="return confirm('추천하시겠습니까?')"href="./likeAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">추천</a>
						<a>/</a>
						<a onclick="return confirm('삭제하시겠습니까?')"href="./deleteAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">삭제</a>
						<a>/</a>
						<a style="color:red" data-toggle="modal" href="#reportModal">신고</a>
					</div>
				</div>
			</div>
		</div>
<%
		}
	}
%>
	</section>
	<ul class="pagination justify-content-center mt-3">
      <li class="page-item">
<%
	if(pageNumber <= 0) {
%>     
        <a class="page-link disabled">이전</a>
<%
	} else {
%>
		<a class="page-link" href="./index.jsp?foodType=<%=URLEncoder.encode(foodType, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">이전</a>
<%
	}
%>
      </li>
      <li class="page-item">
<%
	if(evaluationList.size() < 6) {
%>
        <a class="page-link disabled">다음</a>
<%
	} else {
%>
		<a class="page-link" href="./index.jsp?foodType=<%=URLEncoder.encode(foodType, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">다음</a>
<%
	}
%>
      </li>
    </ul>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">이용 후기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					 <span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-12">
								<label># 방문한 가게 이름</label>
								<input type="text" name="shopName" class="form-control" maxlength="20">
							</div>
							
							
							
						</div>
						<div class="form-row">
							
							<div class="form-group col-sm-5">  <!-- 뭔갈 선택할때 많이 사용 form-group -->
								<label># 가게 종류</label>
								<select name="foodType" class="form-control">
									<option value="한식" selected>한식</option>
									<option value="양식">양식</option>
									<option value="중식">중식</option>
									<option value="일식">일식</option>
									<option value="기타">기타</option>
								</select>
							</div>
							
							<div class="form-group col-sm-7">
								<label># 위치</label>
								<select name="shopLocation" class="form-control">
									<option value="강남구" selected>강남구</option>
									<option value="강동구" >강동구</option>
									<option value="강서구" >강서구</option>
									<option value="강북구" >강북구</option>
									<option value="관악구" >관악구</option>
									<option value="광진구" >광진구</option>
									<option value="구로구" >구로구</option>
									<option value="금천구" >금천구</option>
									<option value="노원구" >노원구</option>
									<option value="동대문구">동대문구</option>
									<option value="도봉구" >도봉구</option>
									<option value="마포구" >마포구</option>
									<option value="서대문구">서대문구</option>
									<option value="성동구" >성동구</option>
									<option value="성북구" >성북구</option>
									<option value="서초구" >서초구</option>
									<option value="송파구" >송파구</option>
									<option value="영등포구">영등포구</option>
									<option value="용산구" >용산구</option>
									<option value="은평구" >은평구</option>
									<option value="종로구" >종로구</option> 
									<option value="중구"	 >중구</option>
									<option value="중랑구">중랑구</option>
									<option value="기타지역">기타</option>
								</select>
							</div>
							
						</div>
						<div class="form-group">
							<label># 제목</label>
							<input type="text" name="Title" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label># 경험을 말해주세요</label>
							<textarea name="Content" class="form-control" maxlength="2048" style="height: 180px;"></textarea>	
						</div>
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label># 평점</label>
								<select name="totalScore" class="form-control">
									<option value="5" selected>5/5 최고예요</option>
									<option value="4">4/5 좋아요</option>
									<option value="3">3/5 보통이에요</option>
									<option value="2">2/5 조금 아쉬워요</option>
									<option value="1">1/5 별로예요</option>
								</select>
							</div>
						</div>
						 
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
		<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					 <span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						<div class="form-group">
							<label>신고할 평가의 제목&내용(구체적일수록 좋습니다.)</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>신고 내용</label>
							<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;">후기 작성자: &#10;신고 사유: &#10;&#10;&#10;&#10;&#10;허위 기재시 불이익을 받으실 수 있습니다.</textarea>	
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-danger">신고하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Jquery 자바스크립트 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가 -->
	<script src="./js/popper.js"></script>
	<!-- bootstrap 자바스크립트 추가 -->
	<script src="./js/bootstrap.min.js"></script>
	
</body>
</html>