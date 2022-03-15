<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type='text/javascript'>

	var jobList;
	var jobListCount = 1;
	$(document).ready(function() {
		// 검색
		$("#search_btn").click(function() {
			searchList(1);
		});

		// 회사명 TXT에서 Click
		$("#search_text").on("keydown", function(key) {
            //키의 코드가 13번일 경우 (13번은 엔터키)
            if (key.keyCode == 13) {
            	searchList(1);
            }
        });
		
		searchList(1);
	});

	function searchList(pageNo) {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/user/api/solar/job/search/all' />");
		comAjax.setCallback("searchListCB");
		comAjax.addParam("category_id", $("#selector_category option:selected").val());
		comAjax.addParam("occupation", $("#selector_ocurrpation option:selected").val());
		comAjax.addParam("name", $("#search_text").val());
		
		comAjax.ajax();
	}


	function searchListCB(data) {
		var total = data.totalCount;
		var body = $("#ul_body");
		
		body.empty();
		if (total == 0) {
			$("#serach_count").text("검색결과 0건");
			var str = "조회된 결과가 없습니다.";
			body.append(str);
		} else {

			$("#serach_count").text("검색결과 " + total + "건");
			jobList = data.result;
			jobListCount = 1;
			
			var str = "";
			$.each(data.result, function(key, value) {
				str += "<li>";
				str += "	<div class='jobTitlearea'><p class='jobTitle'>" + unescapeHtml(value.name) + "</p></div>";
				str += "	<dl>";
				str += "		<dt>코드분류</dt>";
				str += "			<dd>" + value.category_id + ". " + unescapeHtml(value.category_name) + "</dd>";
				str += "			<dd>" + value.category_detail_id + ". " + unescapeHtml(value.category_detail_name) + "</dd>";
				str += "		<dt>직종</dt>";
				str += "			<dd>" + unescapeHtml(value.occupation_name) + "</dd>";
				str += "		<dt>학력</dt>";
				str += "			<dd>" + unescapeHtml(value.education_name) + "</dd>";
				str += "	</dl>";
				str += "	<a href='javascript:void(0)' onclick='detailPopup(\"" + value.job_id + "\");'>상세보기 &gt;</a>";
				str += "</li>";

				// 10개씩만 보여준다.
				if ( (jobListCount%10) == 0 ) {
					return false;
				}
				
				jobListCount++;
			});

			if ( jobListCount >= jobList.length) {
				$("#more_btn").hide();
			}
			else {
				$("#more_btn").show();
			}
			
			body.append(str);
		}
	}

	function jobListMore() {

		var body = $("#ul_body");

		var str = "";
		for ( var i=0; i<jobList.length ; i++) {
			str += "<li>";
			str += "	<div class='jobTitlearea'><p class='jobTitle'>" + unescapeHtml(jobList[i+jobListCount].name) + "</p></div>";
			str += "	<dl>";
			str += "		<dt>코드분류</dt>";
			str += "			<dd>" + jobList[i+jobListCount].category_id + ". " + unescapeHtml(jobList[i+jobListCount].category_name) + "</dd>";
			str += "			<dd>" + jobList[i+jobListCount].category_detail_id + ". " + unescapeHtml(jobList[i+jobListCount].category_detail_name) + "</dd>";
			str += "		<dt>직종</dt>";
			str += "			<dd>" + unescapeHtml(jobList[i+jobListCount].occupation_name) + "</dd>";
			str += "		<dt>학력</dt>";
			str += "			<dd>" + unescapeHtml(jobList[i+jobListCount].education_name) + "</dd>";
			str += "	</dl>";
			str += "	<a href='javascript:void(0)' onclick='detailPopup(\"" + jobList[i+jobListCount].job_id + "\");'>상세보기 &gt;</a>";
			str += "</li>";

			
			// 10개씩만 보여준다.
			if ( i >= 9 || (i+jobListCount) >= (jobList.length-1) ) {
				break;
			}
		}
		jobListCount = jobListCount + 10;

		if ( jobListCount >= jobList.length) {
			$("#more_btn").hide();
		}
		else {
			$("#more_btn").show();
		}
		
		body.append(str);
	}



	function getJobDetail(id) {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/user/api/solar/job/detail'/>");
		comAjax.setCallback("getJobDetailCB");
		comAjax.addParam("job_id", id);
		comAjax.ajax();
	}

	function getJobDetailCB(data){
		
		var jobDetail = data.result;

		$("#name").text(jobDetail.name);
		$("#definition").text(unescapeHtml(jobDetail.definition));
		$("#code").text("코드분류 : " + jobDetail.category_id + ". " + jobDetail.category_name + " > "+ jobDetail.category_detail_id +". " + jobDetail.category_detail_name);
		$("#occupation").text(unescapeHtml(jobDetail.occupation_name));
		$("#education").text(jobDetail.education_name);

		// 난이도
		if ( jobDetail.difficulty == "D000001" ) {
			$("#level_info").text("고급");
		}
		else if ( jobDetail.difficulty == "D000002" ) {
			$("#level_info").text("중급");
		}
		else {
			$("#level_info").text("초급");
		}

		var str = "<img src='data:image/png;base64," + jobDetail.upload_file_image +"' alt='" + jobDetail.attach_file_description + "'>";
		$("#image_file").html(str);

		// 연봉
		$("#salary_level").text(jobDetail.salary_level + "만원");
		// 경력
		if ( jobDetail.career == "") {
			$("#career").text("없음");
		}
		else {
			$("#career").text(jobDetail.career);
		}
		// 학력 
		str = "";
		for (var i=0; i<jobDetail.return_major_list.length; i++){
			str += jobDetail.return_major_list[i].name + ",";
		}
		if ( str == "") {
			$("#major").text("없음");
		}
		else {
			$("#major").text(str.substring(0, str.length-1));
		}
		// 자격증 
		str = "";
		for (var i=0; i<jobDetail.return_license_list.length; i++){
			str += jobDetail.return_license_list[i].kor_name + ",";
		}
		if ( str == "") {
			$("#license").text("없음");
		}
		else {
			$("#license").text(str.substring(0, str.length-1));
		}
		// 지식
		$("#knowledge").html("<li>" + unescapeHtml(jobDetail.knowledge) + "</li>");
		// 기술
		$("#skill").html("<li>" + unescapeHtml(jobDetail.skill) + "</li>");
		// 태도
		$("#attitude").html("<li>" + unescapeHtml(jobDetail.attitude) + "</li>");
		// keco
		$("#keco").html("<li>" + unescapeHtml(jobDetail.keco) + "</li>");
		


		// 대표기업
		str = "";

		// 대표기업
		str = "";
        str += "<h4>관련 기업</h4>";
        if (jobDetail.company_1_name != "") {
        	str += "<div class='coWrap'>";
        	str += "	<div class='inWrap'>";
        	str += "		<h5>" + jobDetail.company_1_name + "</h5>";
        	str += "		<ul class='normal'>";
        	str += "			<li>기업규모 : " + jobDetail.company_1_size + "</li>";
        	str += "			<li>위치 : " + unescapeHtml(jobDetail.company_1_address) + "</li>";
        	str += "			<li>주요 제품 및 서비스 : " + unescapeHtml(jobDetail.company_1_main_product) + "</li>";
        	str += "		</ul>";
        	str += "	</div>";
        	str += "	<div class='imgWrap'>";
        	str += "		<img src='data:image/png;base64," + jobDetail.company_1_logo +"' alt='" + jobDetail.company_1_name + "'>";
        	str += "	</div>";
        	str += "</div>";
		}
        else {
        	str += "<div class='coWrap'>";
        	str += "	<div class='inWrap'>";
        	str += "		<h5>없음</h5>";
        	str += "	</div>";
        	str += "</div>";
       	}
		if (jobDetail.company_2_name != "") {
        	str += "<div class='coWrap'>";
        	str += "	<div class='inWrap'>";
        	str += "		<h5>" + jobDetail.company_2_name + "</h5>";
        	str += "		<ul class='normal'>";
        	str += "			<li>기업규모 : " + jobDetail.company_2_size + "</li>";
        	str += "			<li>위치 : " + unescapeHtml(jobDetail.company_2_address) + "</li>";
        	str += "			<li>주요 제품 및 서비스 : " + unescapeHtml(jobDetail.company_2_main_product) + "</li>";
        	str += "		</ul>";
        	str += "	</div>";
        	str += "	<div class='imgWrap'>";
        	str += "		<img src='data:image/png;base64," + jobDetail.company_2_logo +"' alt='" + jobDetail.company_2_name + "'>";
        	str += "	</div>";
        	str += "</div>";
		}
		else {
        	str += "<div class='coWrap'>";
        	str += "	<div class='inWrap'>";
        	str += "		<h5>없음</h5>";
        	str += "	</div>";
        	str += "</div>";
		}
		if (jobDetail.company_3_name != "") {
        	str += "<div class='coWrap'>";
        	str += "	<div class='inWrap'>";
        	str += "		<h5>" + jobDetail.company_3_name + "</h5>";
        	str += "		<ul class='normal'>";
        	str += "			<li>기업규모 : " + jobDetail.company_3_size + "</li>";
        	str += "			<li>위치 : " + unescapeHtml(jobDetail.company_3_address) + "</li>";
        	str += "			<li>주요 제품 및 서비스 : " + unescapeHtml(jobDetail.company_3_main_product) + "</li>";
        	str += "		</ul>";
        	str += "	</div>";
        	str += "	<div class='imgWrap'>";
        	str += "		<img src='data:image/png;base64," + jobDetail.company_3_logo +"' alt='" + jobDetail.company_3_name + "'>";
        	str += "	</div>";
        	str += "</div>";
		}
		else {
        	str += "<div class='coWrap'>";
        	str += "	<div class='inWrap'>";
        	str += "		<h5>없음</h5>";
        	str += "	</div>";
        	str += "</div>";
		}
		$("#companies").html(str);
		

		// future_career
		str = "";
		if (jobDetail.future_career_1_name != "") {
			str += "<li>" + unescapeHtml(jobDetail.future_career_1_name) + "</li>"
		}
		if (jobDetail.future_career_2_name != "") {
			str += "<li>" + unescapeHtml(jobDetail.future_career_2_name) + "</li>"
		}
		if (jobDetail.future_career_3_name != "") {
			str += "<li>" + unescapeHtml(jobDetail.future_career_3_name) + "</li>"
		}
		if ( str == "") {
			$("#future_career").html("<li>없음</li>");
		}
		else {
			$("#future_career").html(str);
		}

		$('#detail_popup').fadeIn(350);
		$('.mask').fadeIn(350);
	}
	

	function detailPopup(id) {
		getJobDetail(id);
	}
	

</script>

<div id="wrap">
    <header class="sub">
      <div class="headerSubWrap">
        <button class="prev" onclick="location.href='/user/rdt/solar/mobile/main/mainMobile'"></button>
        <h1>태양광산업 일자리 사전</h1>
      </div>
    </header>

    <section>
      <div class="tabs jobs">
        <ul class="tablist" data-hx="h2">
          <li class="tablist__item">
            <a href="#tab01" class="tablist__link tabs__standard__a">분야별</a>
          </li>
          <li class="tablist__item">
            <a href="#tab02" class="tablist__link ">직종별</a>
          </li>
        </ul>
        <div id="tab01" class="js-tabcontent">
          <div class="innerWrap search">
            <fieldset>
              <legend><span>분야별 검색</span></legend>
              <select name="" id="selector_category">
                <option value="">분야 선택</option>
				 <c:forEach items="${commonCode}" var="code">
					<c:if test="${code.master_id == 'M000002'}">
						<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>
					</c:if>
				 </c:forEach>
              </select>
            </fieldset>
          </div>
        </div>
        <div id="tab02" class="js-tabcontent">
          <div class="innerWrap search">
            <fieldset>
              <legend><span>직종별 검색</span></legend>
              <select name="" id="selector_ocurrpation">
             	 <option value="">직종 선택</option>
				 <c:forEach items="${commonCode}" var="code">
					<c:if test="${code.master_id == 'M000004'}">
						<option value="${code.detail_id}">${code.name}</option>
					</c:if>
				 </c:forEach>
              </select>
            </fieldset>
          </div>
        </div>
      </div>
      
      <div class="innerMobileWrap search">
	      <div class="inputWrap">
	        <input type="text" id="search_text">
	        <button type="submit" id="search_btn">검색</button>
	      </div>
	      <button type="button" id-data="termGuide" class="open">일자리 사전 용어가이드</button>
      
	      <div class="result">
	          <div class="searchResult">
	            <p class="resultNum" id="serach_count"></p>
	            <div class="listWrap">
	              <ul class="jobCard" id="ul_body"></ul>
	              <button type="button" class="more" id="more_btn" onclick="jobListMore();">10개 더보기</button>
	            </div>
	          </div>
	      </div>
      </div>
    </section>
  </div>


  <!-- Layer -->
  <div class="mask"></div>
  <!-- 상세보기 -->
  <div id="detail_popup" class="popup">
    <div class="wrap">
      <div class="header">
        <h1>일자리 카드</h1>
      </div>

      <div class="contents">
        <div class="boxWrap">
          <div class="inBox">
            <h2 id="name"></h2>
            <p class="summary" id="definition"></p>
            <p class="code" id="code"></p>
            <ul class="level">
              <li><em class="box">업무 난이도</em></li>
              <li><em class="on" id="level_info"></em></li>
            </ul>
          </div>
          
        </div>
        <div class="imgBox" id="image_file">
		  <!--380*254-->
        </div>
        <div class="boxWrap dt">
          <h3>직무자격</h3>
          <dl class="qualification">
            <dt>요구학력</dt>
            	<dd id="education"></dd>
            <dt>필요경력</dt>
            	<dd id="career"></dd>
            <dt>급여수준</dt>
            	<dd id="salary_level"></dd>
            <dt>전공</dt>
            	<dd id="major"></dd>
            <dt class="last">자격증</dt>
            	<dd id="license"></dd>
          </dl>
        </div>
        <div class="boxWrap">
          <h3>직무능력</h3>
          <ul class="ability">
            <li>
              <h4>지식</h4>
	              <ul id="knowledge"></ul>
            </li>
            <li>
              <h4>기술</h4>
	              <ul id="skill"></ul>
            </li>
            <li>
              <h4>태도</h4>
	              <ul id="attitude"></ul>
            </li>
          </ul>
        </div>
        <div class="boxWrap">
          <h4>관련 일자리</h4>
          <ul class="normal" id="future_career">
          </ul>
        </div>
        <div class="boxWrap">
          <h4>한국고용직업 분류</h4>
          <ul class="normal" id="keco">
            <li>[1521]금속〮재료공학 기술자 및 연구원</li>
          </ul>
        </div>
        
        <div class="boxWrap" id="companies"></div>
        
      </div>
      <button class="btn_close">닫기</button>
    </div>
  </div>

  <!-- 일자리 사전 용어가이드 -->
  <div id="termGuide" class="popup">
    <div class="wrap">
      <div class="header">
        <h1>일자리 사전 용어 가이드</h1>
      </div>

      <div class="contents">
        <table class="tbl dicGuide">
          <caption><span>용어 가이드 안내</span></caption>
          <colgroup>
            <col style="width:25%;">
            <col style="width:25%;">
            <col style="width:50%;">
          </colgroup>
          <thead>
            <tr>
              <th scope="col">대분류</th>
              <th scope="col">중분류</th>
              <th scope="col">항목정의</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>직업</td>
              <td>직업명</td>
              <td>해당 직업의 명칭</td>
            </tr>
            <tr>
              <td>기본정보</td>
              <td>일자리 정의</td>
              <td>해당 직업의 명칭</td>
            </tr>
            <tr>
              <td rowspan="4">직무자격</td>
              <td>학력</td>
              <td>해당 직업을 갖는데 필요한 일반적인 학력 수준</td>
            </tr>
            <tr>
              <td>전공</td>
              <td>해당 직업과 관련된 학과(전공)</td>
            </tr>
            <tr>
              <td>자격증</td>
              <td>해당 직업을 갖는데 필요한 자격증(면허)</td>
            </tr>
            <tr>
              <td>필요 경력</td>
              <td>해당 직업을 갖는데 필요한 경력기간</td>
            </tr>
            <tr>
              <td>직무 난이도</td>
              <td>직무 난이도</td>
              <td>해당 직업의 난이도(지식, 기술전문성 수준 등)</td>
            </tr>
            <tr>
              <td rowspan="3">직무능력</td>
              <td>지식</td>
              <td>학교, 학원, 직장 등을 통해서 습득 가능한 학문적 지식 또는 직무를 수행하는데 
                필요한 기초 이론적 지식을 의미</td>
            </tr>
            <tr>
              <td>기술</td>
              <td>산업 현장에서 실무를 수행하는데 필요한 행동 능력 및 기술을 의미</td>
            </tr>
            <tr>
              <td>태도</td>
              <td>직무를 수행함에 있어 필요한 기본 소양 및 마음가짐, 태도를 의미</td>
            </tr>
            <tr>
              <td>근무여건</td>
              <td>급여수준</td>
              <td>종사자들의 일반적인 급여수준</td>
            </tr>
            <tr>
              <td>일거리 전망</td>
              <td>일자리 전망</td>
              <td>일자리 유망성(전문가 의견 반영)</td>
            </tr>
            <tr>
              <td rowspan="2">기타</td>
              <td>관련 직업 정보</td>
              <td>해당 직업과 관련 있는 타 직업 명칭</td>
            </tr>
            <tr>
              <td>한국고용직업분류</td>
              <td>해당 직업과 매칭되는 한국고용직업분류(KECO)</td>
            </tr>
          </tbody>
        </table>
      </div>
      <button class="btn_close">닫기</button>
    </div>
  </div>

  <script>
    $(function () {
      $('.open').on('click', function () {
        var id = $(this).attr("id-data");
        $('#' + id).fadeIn();
        // $('.mask').css({'display':'block'});
        $(document.body).css({'overflow': 'hidden'});
      });
      $('.btn_close').on('click', function () {
        var id = $(this).parent('div').parent('div').attr('id');
        $('#' + id).css({'display':'none'});
        $('.mask').css({'display':'none'});
        $(document.body).css({'overflow': 'auto'});
      });
    });
  </script>
