<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

  
<script type='text/javascript'>

	$(document).ready(function() {
	 	getJobDetail();
	});


	function getJobDetail(id) {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/user/api/solar/job/detail'/>");
		comAjax.setCallback("getJobDetailCB");
		comAjax.addParam("job_id", $("#job_id").val());
		comAjax.ajax();
	}

	function getJobDetailCB(data){
		
		var jobDetail = data.result;

		$("#name").text(unescapeHtml(jobDetail.name));
		$("#definition").text(unescapeHtml(jobDetail.definition));
		$("#code").text("코드분류 : " + jobDetail.category_id + ". " + jobDetail.category_name + " > "+ jobDetail.category_detail_id +". " + jobDetail.category_detail_name);
		$("#occupation").text(unescapeHtml(jobDetail.occupation_name));
		$("#education").text(jobDetail.education_name);
		$("#difficulty").text(jobDetail.difficulty_name);
		

		
		var str = "";
		// 난이도
		$("#level_info").empty();
		str += "<li><em class='box'>업무 난이도</em></li>"
		if ( jobDetail.difficulty == "D000001" ) {
			str += "<li><em>초급</em></li><li><em>중급</em></li><li><em class='on'>고급</em></li>";
		}
		else if ( jobDetail.difficulty == "D000002" ) {
			str += "<li><em>초급</em></li><li><em class='on'>중급</em></li><li><em>고급</em></li>";
		}
		else {
			str += "<li><em class='on'>초급</em></li><li><em>중급</em></li><li><em>고급</em></li>";
		}
		$("#level_info").append(str);
		// upload_file_image
		$("#upload_file_image").html("<img src='data:image/png;base64," + jobDetail.upload_file_image +"' alt='" + unescapeHtml(jobDetail.name) + "'>");
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
		// 관련 직업
		$("#related_job").html("<li>" + unescapeHtml(jobDetail.related_job) + "</li>");
		// 한국고용직업 분류
		$("#keco").html("<li>" + unescapeHtml(jobDetail.keco) + "</li>");
		
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
	}
</script>


<input type="hidden" id="job_id" name="job_id" value='<c:out value="${vo.job_id}"/>' />
<div id="wrap">
    <section>
      <div class="subVisual search">
        <div class="titleArea">
          <h2>태양광산업 일자리 사전</h2>
          	<span>태양광산업의 일자리 검색 기능 및 일자리별 상세정보 페이지를 제공합니다.</span>
        </div>
      </div>
    </section>

    <section>
      <div class="subWrap">
        <ul class="breadcrumb">
          <li><img src="/assets/img/btn/breadcrumb_home.png" alt="홈"></li>
          <li>태양광산업 일자리 검색</li>
        </ul>

        <div class="boxWrap divide">
          <div class="inBox">
            <h3 id="name"></h3>
            <p class="summary" id="definition"></p>
            <p class="code" id="code"></p>
            <ul class="level" id="level_info">
              <li><em class="box">업무 난이도</em></li>
              <li><em>초급</em></li>
              <li><em>중급</em></li>
              <li><em class="on">고급</em></li>
            </ul>
          </div>
          <div class="imgBox" id="upload_file_image">
            <!-- <img class="jImg" src="/assets/img/job_img.png" alt=""> -->
          </div>
        </div>
        <div class="boxWrap dt">
          <h4>직무자격</h4>
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
          <h4>직무능력</h4>
          <ul class="ability">
            <li>
              <h5>지식</h5>
              <ul id="knowledge">
              </ul>
            </li>
            <li>
              <h5>기술</h5>
              <ul id="skill">
              </ul>
            </li>
            <li>
              <h5>태도</h5>
              <ul id="attitude">
              </ul>
            </li>
          </ul>
        </div>
<!--         <div class="boxWrap">
          <h4>일자리 전망</h4>
          <ul class="normal">
            <li>글로벌 메이저 태양전지 생산기업인 한화큐셀, 현대에너지솔루션, 신성이엔지, 엘지전자 등을 중심으로 지속적인 태양전지 생산라인 증설 예정임. 이에 따라 관련 일자리가 다수 창출될 것으로 전망됨</li>
            <li>태양광발전사업의 경쟁력 향상을 위해서는 새로운 셀 공정 및 구조를 연구개발 하는 것이 중요하므로, 향후 관련 분야의 일자리 수요가 증가할 전망됨</li>
          </ul>
        </div> -->
        <div class="boxWrap">
          <h4>관련 일자리</h4>
          <ul class="normal" id="related_job">
          </ul>
        </div>
        <div class="boxWrap">
          <h4>한국고용직업 분류</h4>
          <ul class="normal" id="keco">
          </ul>
        </div>
        <div class="boxWrap" id="companies">
        </div>
      </div>
    </section>
  	<div class="btnWrap">
	  <a href="/user/rdt/solar/jobDictionary/main" class="btn viewList">목록보기</a>
	</div>
  </div>

  <script>
    $(window).scroll(function () {
      var position = $(window).scrollTop();
      if (position > 80) {
        // $('.swiper-container').fadeOut();
        $('header').addClass('on');
      } else {
        // $('.swiper-container').fadeIn();
        $('header').removeClass('on');
      }
    });
  </script>