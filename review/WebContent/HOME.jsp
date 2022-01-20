<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey={본인 키 }&libraries=services"></script>
</head>
<body>




<%
	request.setCharacterEncoding("UTF-8");
	String gu = "마포구";
	String food_category="한식";
	if(request.getParameter("gu") != null) {
		gu = request.getParameter("gu");
	}
	if(request.getParameter("food_category") != null) {
		food_category = request.getParameter("food_category");
	}
%>
<section class="container">
	<h3>더 많은 곳을 둘러 보세요!</h3>
		<form method="get" class="form-inline mt-3">
			<select name="gu" id="gu" class="form-control mx-1 mt-2">
				<option value="마포구" <% if(gu.equals("마포구")) out.println("selected"); %>>마포구</option>
				<option value="종로구" <% if(gu.equals("종로구")) out.println("selected"); %>>종로구</option> 
				<option value="중구" <% if(gu.equals("중구")) out.println("selected"); %>>중구</option>
				<option value="용산구" <% if(gu.equals("용산구")) out.println("selected"); %>>용산구</option>
				<option value="성동구" <% if(gu.equals("성동구")) out.println("selected"); %>>성동구</option>
				<option value="광진구" <% if(gu.equals("광진구")) out.println("selected"); %>>광진구</option>
				<option value="동대문구" <% if(gu.equals("동대문구")) out.println("selected"); %>>동대문구</option>
				<option value="중랑구" <% if(gu.equals("중랑구")) out.println("selected"); %>>중랑구</option>
				<option value="성북구" <% if(gu.equals("성북구")) out.println("selected"); %>>성북구</option>
				<option value="강북구" <% if(gu.equals("강북구")) out.println("selected"); %>>강북구</option>
				<option value="도봉구" <% if(gu.equals("도봉구")) out.println("selected"); %>>도봉구</option>
				<option value="노원구" <% if(gu.equals("노원구")) out.println("selected"); %>>노원구</option>
				<option value="은평구" <% if(gu.equals("은평구")) out.println("selected"); %>>은평구</option>
				<option value="서대문구" <% if(gu.equals("서대문구")) out.println("selected"); %>>서대문구</option>
				<option value="강서구" <% if(gu.equals("강서구")) out.println("selected"); %>>강서구</option>
				<option value="구로구" <% if(gu.equals("구로구")) out.println("selected"); %>>구로구</option>
				<option value="영등포구" <% if(gu.equals("영등포구")) out.println("selected"); %>>영등포구</option>
				<option value="관악구" <% if(gu.equals("관악구")) out.println("selected"); %>>관악구</option>
				<option value="서초구" <% if(gu.equals("서초구")) out.println("selected"); %>>서초구</option>
				<option value="강남구" <% if(gu.equals("강남구")) out.println("selected"); %>>강남구</option>
				<option value="송파구" <% if(gu.equals("송파구")) out.println("selected"); %>>송파구</option>
				<option value="강동구" <% if(gu.equals("강동구")) out.println("selected"); %>>강동구</option>
				<!-- 기본적으로 모든 옵션 선택 selected 사용 -->

			</select>
			<select name="food_category" id="food_category" class="form-control mx-1 mt-2">
				<option value="한식" <% if(food_category.equals("한식")) out.println("selected"); %>>한식</option>
				<option value="양식" <% if(food_category.equals("양식")) out.println("selected"); %>>양식</option>
				<option value="중식" <% if(food_category.equals("중식")) out.println("selected"); %>>중식</option>
				<option value="일식" <% if(food_category.equals("일식")) out.println("selected"); %>>일식</option>
			</select>
			<div>
                <form onsubmit="searchPlaces(); return false;">
                    <!--  키워드 : <input type="text" value="<%%>" id="keyword" size="15"> -->
                    <button type="submit" class="btn btn-outline-info mx-1 mt-2">검색하기</button> 
                </form>
            </div>  
		</form>
	</section>
<div>
	<input type="file" id="real-input" class="image_inputType_file" accept="img/*" required multiple>
	<button class="browse-btn">사진업로드</botton>
</div>
<script>
const browseBtn = document.querySelector('.browse-btn');
const realInput = document.querySelector('#real-input');

browseBtn.addEventListener('click',()=>{
	realInput.click();
});
</script>
<!-- 미리보기 기능 -->
<h3>이미지 미리보기</h3>
<div id="imagePreview">
	<img id="img" />
	
	
	<script>
	function readInputFile(e){
	    var sel_files = [];
	    
	    sel_files = [];
	    $('#imagePreview').empty();
	    
	    var files = e.target.files;
	    var fileArr = Array.prototype.slice.call(files);
	    var index = 0;
	    
	    fileArr.forEach(function(f){
	    	if(!f.type.match("image/.*")){
	        	alert("이미지 확장자만 업로드 가능합니다.");
	            return;
	        };
	        if(files.length < 11){
	        	sel_files.push(f);
	            var reader = new FileReader();
	            reader.onload = function(e){
	            	var html = `<a id=img_id_${index}><img src=${e.target.result} data-file=${f.name} /></a>`;
	                $('imagePreview').append(html);
	                index++;
	            };
	            reader.readAsDataURL(f);
	        }
	    })
	    if(files.length > 11){
	    	alert("최대 10장까지 업로드 할 수 있습니다.");
	    }
	}

	$('#real-input').on('change',readInputFile);
	
	</script>
</div>


<div class="map_wrap mt-3">
    <div id="map" style="width:80%;height:450px;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>


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

<form name="writeFrom" method="post" enctype="multipart/form-data" action="Post.jsp">
  <input name="maker" type="hidden" value="<%=(String)session.getAttribute("USERID")%>">
  <input name="saleCategory" type="hidden" value="개인">
  <table width="514" border="" align="center" cellspacing="0" cellpadding="3">
    <tr>
      <th width="120" scope="row">판매범주</th>
      <td width="208">
      <P>
          <label>개인상품 등록</label>
      <p>
    </td>
    </tr>
    <tr>
      <th scope="row">물품범주</th>
      <td><label for="select"></label>
        <select name="itemCategory" size="1" id="select">
          <option selected="selected">선택</option>
          <option value="전자제품">전자제품</option>
          <option value="스포츠">스포츠</option>
          <option value="의류패션">의류패션</option>
          <option value="도서">도서</option>
          <option value="가구">가구</option>
          <option value="기타">기타</option>
      </select></td>
    </tr>
    <tr>
      <th scope="row">제목</th>
      <td><input type="text" name="title" maxlength="23" size=50>
      <input type="hidden" name="maker" value="<%=session.getAttribute("USERID") %>"></td>
    </tr>
    <tr>
      <th scope="row">물품이름</th>
      <td><input type="text" name="itemName" maxlength="10"></td>
    </tr>
    <tr>
      <th scope="row">물품가격</th>
      <td><input type="text" name="price" maxlength="10">원</td>
    </tr>
    <tr>
      <th scope="row">거래방법</th>
      <td><input type="text" name="tradeWay" maxlength="20"></td>
    </tr>
    <tr>
      <th scope="row">연락처</th>
      <td><input type="text" name="phone" maxlength="20"></td>
    </tr>
    <tr>
      <th scope="row">물품소개</th>
      <td><textarea name="content" cols="45" rows="10"></textarea></td>
    </tr>
    <tr>
      <th scope="row">비밀번호</th>
      <td><input type="password" name="password" maxlength="5"></td>
    </tr>
    <tr>
      <th scope="row">물품사진</th>
      <td>
 
      <input type="file" name="imageFile" size=40>
   
      </td>
    </tr>
    <tr>
      <th colspan="2" scope="row"><input type="button"
                                        value="올리기" OnClick="javascript:writeCheck();">
      <input type=button value="취소" OnClick="javascript:history.back(-1)">
      </th>
    </tr>
  </table>
</form>
<!--  
<form class="mx-3 mx-10 col-8">
<input type="file" name="file" id="imageFileOpenInput" accept="image/*">
</form>
<form method="post" action="upload" enctype="multipart/form-data">

  <div>
    file : <input type="file" name="file" accept="image/*">
  </div>
  
  <input type="submit">

</form>
-->

<form action="uploadImage.jsp" method="post" enctype="multipart/form-data">
	이미미이이지: <input type="file" name="file"><br><input type="submit" value="업로오오오드"><br>
</form>

	<!-- Jquery 자바스크립트 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가 -->
	<script src="./js/popper.js"></script>
	<!-- bootstrap 자바스크립트 추가 -->
	<script src="./js/bootstrap.min.js"></script>
	
</body>
</html>

