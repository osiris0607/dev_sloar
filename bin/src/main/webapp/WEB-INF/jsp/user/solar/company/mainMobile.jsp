<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type='text/javascript'>
	var companyList;
	
	$(document).ready(function() {
		// 검색
		$("#search_btn").click(function() {
			searchMap();
		});

		// 생태계 분류 Click
	 	$("#selector_category").change(function(){
		    categoryId =  $(this).val();
		    categoryChange(categoryId);
		});

		// 해정 구역 정보 Click
	 	$("#selector_region").change(function(){
	 		var selector_regionId =  $("#selector_region").val();
	 		selector_regionChange(selector_regionId);
		});
		
		selectorInit();
		getselector_regionList();
		searchMap();
	});

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

		$('#job_detail_popup').fadeIn().css({'z-index':'20'});
		$('.mask').fadeIn(350);
	}
	

	function jobDetailPopup(id) {
		getJobDetail(id);
	}

	
	function initMap() {
		var chkVal = ["11", "21", "22", "23", "24" ,"25" ,"26" ,"29", "31", "32", "33", "34", "35", "36", "37", "38", "39"];
		for (var i = 0; i < chkVal.length; i++) 
		{
			$("#map_" + chkVal[i]).text("0");
			$("#num_" + chkVal[i]).text("0");
			$("#card_" + chkVal[i]).empty();
			
			var title = "";
			if ( $("#selector_category option:selected").val() != "" ) {
				title += "<em class=en>" + $("#selector_category option:selected").val() + ".</em>" + $("#selector_category option:selected").text();
			}
			if ( $("#selector_category_detail option:selected").val() != "" ) {
				title += "<em class=en>" + " &gt; " + $("#selector_category_detail option:selected").val() + ".</em>" + $("#selector_category_detail option:selected").text();
			}
			
			if (title != "" ) {
				$("#title_" + chkVal[i]).html(title);
			}
			else {
				$("#title_" + chkVal[i]).html("<em class='en'>ALL</em>");
			}
			
		}
		$("#search_count").text("검색결과 " + "0" + "건");
		$("#search_count_tab02").text("검색결과 " + "0" + "건");
		
		$('.mapCard').css({'display':'none'});
        if ($('path').hasClass('on')) {
          $('path, .prov, .prov em, .prov span').removeClass('on');
        }

	}

	function makeMap(regionValue, companyList) {
		$("#map_" + regionValue.region).text(regionValue.region_count);
		$("#num_" + regionValue.region).text(regionValue.region_count);
		var card = $("#card_" + regionValue.region);
		var str = "";
		card.empty();
		$.each(companyList, function(key, value) {
			if (value.region == regionValue.region) {
				//str += "<li>" +value.name + "</li>";
				str += "<li><a href='javascript:void(0)' class='hasId' onclick='detailPopup(\"" + value.company_id + "\")'>" + value.name + "</a></li>";
			}
		});
		card.append(str);
		
		if ( regionValue.region == $("#selector_region option:selected").val() ) {

            $('.mapCard').css({'display':'none'});
            if ($('path').hasClass('on')) {
              $('path, .prov, .prov em, .prov span').removeClass('on');
            }
			
			var idx = "";
			if (regionValue.region == "11" ) {
				idx = "Seoul";
				$("path[name=서울]").attr("class", "on");
			}
			if (regionValue.region == "21" ) {
				idx = "Busan";
				$("path[name=부산]").attr("class", "on");
			}
			if (regionValue.region == "22" ) {
				idx = "Daegu";
				$("path[name=대구]").attr("class", "on");
			}
			if (regionValue.region == "23" ) {
				idx = "Incheon";
				$("path[name=인천]").attr("class", "on");
			}
			if (regionValue.region == "24" ) {
				idx = "Gwangju";
				$("path[name=광주]").attr("class", "on");
			}
			if (regionValue.region == "25" ) {
				idx = "Daejeon";
				$("path[name=대전]").attr("class", "on");
			}
			if (regionValue.region == "26" ) {
				idx = "Ulsan";
				$("path[name=울산]").attr("class", "on");
			}
			if (regionValue.region == "29" ) {
				idx = "Sejong";
				$("path[name=세종]").attr("class", "on");
			}
			if (regionValue.region == "31" ) {
				idx = "Gyeonggi";
				$("path[name=경기도]").attr("class", "on");
			}
			if (regionValue.region == "32" ) {
				idx = "Gangwon";
				$("path[name=강원도]").attr("class", "on");
			}
			if (regionValue.region == "33" ) {
				idx = "Chungbuk";
				$("path[name=충청북도]").attr("class", "on");
			}
			if (regionValue.region == "34" ) {
				idx = "Chungnam";
				$("path[name=충청남도]").attr("class", "on");
			}
			if (regionValue.region == "35" ) {
				idx = "Jeonbuk";
				$("path[name=전라북도]").attr("class", "on");
			}
			if (regionValue.region == "36" ) {
				idx = "Jeonnam";
				$("path[name=전라남도]").attr("class", "on");
			}
			if (regionValue.region == "37" ) {
				idx = "Gyeongbuk";
				$("path[name=경상북도]").attr("class", "on");
			}
			if (regionValue.region == "38" ) {
				idx = "Gyeongnam";
				$("path[name=경상남도]").attr("class", "on");
			}
			if (regionValue.region == "39" ) {
				idx = "Jeju";
				$("path[name=제주도]").attr("class", "on");
			}
			
            if ($('#' + idx + '.mapCard').css('display') == 'none') {
              $('#' + idx + '.mapCard').fadeIn();
              $('.' + idx).addClass('on');
              $('.' + idx).addClass('on');
            }
			
		}
	}

	function detailPopup(id) {
		$.each(companyList, function(key, value) {
			if (value.company_id == id){
				// 회사명
				$("#company_name").text(value.name);
				// 검색 분류
				var title = "";
				if ( $("#selector_category option:selected").val() != "" ) {
					title += "<em class=en>" + $("#selector_category option:selected").val() + ".</em>" + $("#selector_category option:selected").text();
				}
				if ( $("#selector_category_detail option:selected").val() != "" ) {
					title += "<em class=en>" + " &gt; " + $("#selector_category_detail option:selected").val() + ".</em>" + $("#selector_category_detail option:selected").text();
				}
				
				if (title != "" ) {
					$("#company_category").html(title);
				}
				else {
					$("#company_category").html("<em class='en'>ALL</em>");
				}

				// Info
				var str = "";
				var body = $("#company_info");
				body.empty();
				str += "<dl>";
				str += " <dt>기업명</dt>";
				str += " 	<dd>" + value.name + "</dd>";
				str += " <dt>표준산업분류</dt>";
				str += " 	<dd>" + value.ksic + "</dd>";
				str += " <dt>주소</dt>";
				str += " 	<dd>" + value.address + "</dd>";
				str += " <dt>주력 제품/서비스</dt>";
				str += " 	<dd>" + value.main_product + "</dd>";
				str += " <dt>대표번호</dt>";
				str += " 	<dd>" + value.phone + "</dd>";
				str += " <dt>홈페이지</dt>";
				str += " 	<dd><a href='" + value.home_page + "' target='_blank'>" + value.home_page + "</a></dd>";
				str += "</dl>";
				body.append(str);
				
				// 연관 직업
				str = "";
				var job = $("#relative_job");
				job.empty();
				str += "<div class='relWrap'>";
				str += "	<h3>연관 일자리</h3>";
				if ( gfn_isNull(value.associated_job_1) == false ) {
					str += "	<div class='relBox'>";
					str += "		<h4>" + unescapeHtml(value.associated_job_1_name) + "</h4>";
					str += "		<p>" + unescapeHtml(value.associated_job_1_definition) + "</p>";
					str += "		<a href='javascript:void(0)' class='btn_detail' onclick='jobDetailPopup(\"" + value.associated_job_1 + "\");'>상세보기 &gt;</a>";
					str += "	</div>";
				}

				if ( gfn_isNull(value.associated_job_2) == false ) {
					str += "	<div class='relBox'>";
					str += "		<h4>" + unescapeHtml(value.associated_job_2_name) + "</h4>";
					str += "		<p>" + unescapeHtml(value.associated_job_2_definition) + "</p>";
					str += "		<a href='javascript:void(0)' class='btn_detail' onclick='jobDetailPopup(\"" + value.associated_job_2 + "\");'>상세보기 &gt;</a>";
					str += "	</div>";
				}

				if ( gfn_isNull(value.associated_job_3) == false ) {
					str += "	<div class='relBox'>";
					str += "		<h4>" + unescapeHtml(value.associated_job_3_name) + "</h4>";
					str += "		<p>" + unescapeHtml(value.associated_job_3_definition) + "</p>";
					str += "		<a href='javascript:void(0)' class='btn_detail' onclick='jobDetailPopup(\"" + value.associated_job_3 + "\");'>상세보기 &gt;</a>";
					str += "	</div>";
				}
				job.append(str);
				
				// each break
				return false;
			}
		});
		
		$('#detail_popup').fadeIn().css({'z-index':'20'});
	}

	function searchMap() {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/user/api/solar/company/search/region' />");
		comAjax.setCallback("searchMapCB");

		comAjax.addParam("category_id", $("#selector_category option:selected").val());
		comAjax.addParam("category_detail_id", $("#selector_category_detail option:selected").val());
		comAjax.addParam("region", $("#selector_region option:selected").val());
		comAjax.addParam("region_detail", $("#selector_selector_region_detail option:selected").val());
		comAjax.addParam("size", $("#selector_size option:selected").val());
		comAjax.ajax();
	}

	function searchMapCB(data) {
		// Map 초기화
		initMap();

		// Data Count
		if (data.result != null) {
			$("#search_count").text("검색결과 " + data.result.length + "건");
			$("#search_count_tab02").text("검색결과 " + data.result.length + "건");
			companyList = data.result;
		}

		// Map 만들기
		$.each(data.result_region, function(key, value) {
			switch (value.region) {
				case "11":
					makeMap(value, data.result);
					break;
				case "21":
					makeMap(value, data.result);
					break;
				case "22":
					makeMap(value, data.result);
					break;
				case "23":
					makeMap(value, data.result);
					break;
				case "24":
					makeMap(value, data.result);
					break;
				case "25":
					makeMap(value, data.result);
					break;
				case "26":
					makeMap(value, data.result);
					break;
				case "29":
					makeMap(value, data.result);
					break;
				case "31":
					makeMap(value, data.result);
					break;
				case "32":
					makeMap(value, data.result);
					break;
				case "33":
					makeMap(value, data.result);
					break;
				case "34":
					makeMap(value, data.result);
					break;
				case "35":
					makeMap(value, data.result);
					break;
				case "36":
					makeMap(value, data.result);
					break;
				case "37":
					makeMap(value, data.result);
					break;
				case "38":
					makeMap(value, data.result);
					break;
				case "39":
					makeMap(value, data.result);
					break;
			}
		});

		searchList(1);
	}

	function searchList(pageNo) {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/user/api/solar/company/search/all' />");
		comAjax.setCallback("searchListCB");

		comAjax.addParam("category_id", $("#selector_category option:selected").val());
		comAjax.addParam("category_detail_id", $("#selector_category_detail option:selected").val());
		comAjax.addParam("region", $("#selector_region option:selected").val());
		comAjax.addParam("region_detail", $("#selector_selector_region_detail option:selected").val());
		comAjax.addParam("size", $("#selector_size option:selected").val());
		comAjax.ajax();
	}

	function searchListCB(data) {
		// List 만들기
		var total = data.totalCount;
		var body = $("#list_body");
		body.empty();
		if (total == 0) {
			var str = "<tr>" + "<td colspan='8'>조회된 결과가 없습니다.</td>" + "</tr>";
			body.append(str);
		} else {
		
			var index = 1;
			var str = "";
			$.each(data.result, function(key, value) {
				str += "<tr>";
				str += "	<td>"+ value.size_name + "</td>";
				str += "	<td>"+ value.region_name + "</td>";
				str += "	<td>"+ value.region_detail_name.replace(value.region_name, "").replace(" ", "") + "</td>";
				str += "	<td><a href='javascript:void(0)' onclick='detailPopup(\"" + value.company_id + "\")'>" + value.name + "</a></td>";
				str += "</tr>";

				index++;
			});
			body.append(str);
		}
	}

	function getselector_regionList() {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/user/api/util/openapi/sgis/administrativeDistrict/all' />");
		comAjax.setCallback("getselector_regionListCB");
		comAjax.ajax();
	}

	function getselector_regionListCB(data) {
		var str = "";
		selector_regionList = data.result;
		var selector_region = $("#selector_region"); 
		selector_region.empty();

		str += "<option value=''>지역</option>";
		$.each(selector_regionList, function(key, value) {
			if (value.master_id == "D000001") {
				str += "<option value=\"" + value.code + "\">" + value.addr + "</option>";
			}
		});
		selector_region.append(str); 
	}

	function selector_regionChange(selector_regionId){
		var str = "";
		var selector_regionDetail = $("#selector_selector_region_detail"); 
		selector_regionDetail.empty();

		str += "<option value=''>지역 세부</option>";
		$.each(selector_regionList, function(key, value) {
			if (value.master_id == "D000002" && value.parent_id == selector_regionId ) {
				str += "<option value=\"" + value.code + "\">" + value.addr + "</option>";
			}
		});
		
		selector_regionDetail.append(str); 
	}

	function categoryChange(categoryId) {
		if (categoryId != ""){
			// 생테게 세부 분류 Select 생성	
	 		str = "";
			var categoryDetail = $("#selector_category_detail"); 
			categoryDetail.empty();
			str += '<option value="">생태계 세부</option>';
			<c:forEach items="${commonCode}" var="code">
				<c:if test="${code.master_id == 'M000003'}">
					if (categoryId == "${fn:escapeXml(code.parent_id)}") {
						str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
					}
				</c:if>
			</c:forEach>
			categoryDetail.append(str); 
		} 
		else {
	 		var str = "";
			var category = $("#selector_category"); 
			category.empty();
			str += '<option value="">생태계 분류</option>';
			<c:forEach items="${commonCode}" var="code">
				<c:if test="${code.master_id == 'M000002'}">
					str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
				</c:if>
			</c:forEach>	
			category.append(str);
			
	 		str = "";
			var categoryDetail = $("#selector_category_detail"); 
			categoryDetail.empty();
			str += '<option value="">생태계 세부</option>';
			categoryDetail.append(str);
		}
	}

	function selectorInit() {
 		var str = "";
		var category = $("#selector_category"); 
		category.empty();
		str += '<option value="">생태계 분류</option>';
		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000002'}">
				str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
			</c:if>
		</c:forEach>	
		category.append(str);
		
 		str = "";
		var categoryDetail = $("#selector_category_detail"); 
		categoryDetail.empty();
		str += '<option value="">생태계 세부</option>';
		categoryDetail.append(str); 


 		str = "";
 		var selector_regionDetail = $("#selector_selector_region_detail");
 		selector_regionDetail.empty();
		str += '<option value="">지역 세부</option>';
		selector_regionDetail.append(str); 


		str = "";
		var size = $("#selector_size"); 
		size.empty();
		str += '<option value="">기업 유형</option>';
		// License Category 별로 License Selector를 만든다.
       	<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000014'}">
				str += '<option value="${code.detail_id}">${code.name}</option>';
			</c:if>
		</c:forEach>
		size.append(str);
		
	}
</script>



<div id="wrap">
    <header class="sub">
      <div class="headerSubWrap">
        <button class="prev" onclick="location.href='/user/rdt/solar/mobile/main/mainMobile';"></button>
        <h1>일자리 지도보기</h1>
      </div>
    </header>

    <section>
      <fieldset>
        <legend><span>조건검색</span></legend>
        <ul class="searchWrap inMap">
          <li>
            <select name="" id="selector_category">
            </select>
          </li>
          <li>
            <select name="" id="selector_category_detail">
            </select>
          </li>
          <li>
            <select name="" id="selector_region">
            </select>
          </li>
          <li>
            <select name="" id="selector_selector_region_detail">
            </select>
          </li>
          <li>
            <select name="" id="selector_size">
            </select>
          </li>
          <li>
            <button type="submit" id="search_btn">검색</button>
          </li>
        </ul>
      </fieldset>

      <div class="tabs map">
        <ul class="tablist" data-hx="h2">
          <li class="tablist__item">
            <a href="#tab01" id="label_robust_accessible" class="tablist__link tabs__standard__a">지도보기</a>
          </li>
          <li class="tablist__item">
            <a href="#tab02" id="label_keyboard_navigation" class="tablist__link ">목록으로 보기</a>
          </li>
        </ul>
        <div id="tab01" class="js-tabcontent">
          <div class="bsMap">
            <span class="resultTxt" id="search_count"></span>
            <div class="bsMapWrap">
              <div class="prov Gyeonggi" data-num="Gyeonggi">
                <em id="map_31">0</em><br />
                <span>경기도</span>
              </div>
              <div class="prov Seoul" data-num="Seoul">
                <em id="map_11">0</em><br />
                <span>서울</span>
              </div>
              <div class="prov Incheon" data-num="Incheon">
                <em id="map_23">0</em><br />
                &nbsp;&nbsp;&nbsp;&nbsp;<span>인천</span>
              </div>
              <div class="prov Gangwon" data-num="Gangwon">
                <em id="map_32">0</em><br />
                <span>강원도</span>
              </div>
              <div class="prov Chungnam" data-num="Chungnam">
                <em id="map_34">0</em><br />
                <span>충청남도</span>
              </div>
              <div class="prov Sejong" data-num="Sejong">
               <em id="map_29">0</em><br />
                <span>세종</span>
              </div>
              <div class="prov Daejeon" data-num="Daejeon">
                <em id="map_25">0</em><br />
                <span>대전</span>
              </div>  
              <div class="prov Chungbuk" data-num="Chungbuk">
                <em id="map_33">0</em><br />
                <span>충청북도</span>
              </div>
              <div class="prov Daegu" data-num="Daegu">
                <em id="map_22">0</em><br />
                <span>대구</span>
              </div>
              <div class="prov Ulsan" data-num="Ulsan">
                <em id="map_26">0</em><br />
                <span>울산</span>
              </div>
              <div class="prov Busan" data-num="Busan">
                <em id="map_21">0</em><br />
                <span>부산</span>
              </div>
              <div class="prov Gyeongbuk" data-num="Gyeongbuk">
               <em id="map_37">0</em><br />
                <span>경상북도</span>
              </div>
              <div class="prov Gyeongnam" data-num="Gyeongnam">
                <em id="map_38">0</em><br />
                <span>경상남도</span>
              </div>
              <div class="prov Jeonbuk" data-num="Jeonbuk">
                <em id="map_35">0</em><br />
                <span>전라북도</span>
              </div>
              <div class="prov Jeonnam" data-num="Jeonnam">
                <em id="map_36">0</em><br />
                <span>전라남도</span>
              </div>
              <div class="prov Gwangju" data-num="Gwangju">
                <em id="map_24">0</em><br />
                <span>광주</span>
              </div>
              <div class="prov Jeju" data-num="Jeju">
                <em id="map_39">0</em><br />
                <span>제주</span>
              </div>
              <svg xmlns="http://www.w3.org/2000/svg" width="360"  viewBox="0 0 481.077 700.971">
                <defs>
                    <style>
                        path {fill:#fafafa;stroke:#a7a7a7;cursor:pointer}
                        path:hover, path.on {fill:#d02e39}
                    </style>
                </defs>
                <g id="map" transform="translate(-249.038 -106.15)">
                  <path name="경기도" data-num="Gyeonggi" d="M494.995 287.954l-.607-5.464-12.752-2.833-1.417-3.846-13.561-4.251-6.291-29.284 10.885-7.336-.988-8.3-15.751-8.516-5.781-12.624-10.272-.988-9.285-5.73-12.446 2.766-7.112-14.223-7.519-3.343-5.759 8.463.532 6.377-8.588 4.216-2.536 9.7-8.653 9.4-11.041 4.326-.894 12.536-5.968 13.576-10.375.15-2.149 19.874 10.382 4.463 12.288 2.779 7.143 10.733-.922 10.223-5.866 13.991 8.495 5.24-.451 4.791-10.107-1.81-3.275 2.932 2.744 5.408-3.432 1.79 1.79 8.653 6.862.6 1.755 2.833-.955 7.809 3.378 2.934 7.378-2.616 4.408 1.72-.895 7.162-7.012 2.088 9.474 12.215 14.064-3.166 14.573-5.465 14.168 9.917 5.667-4.452 15.18-16.395h11.537l4.453-6.073 10.323-8.7 8.905-15.383.4-16.192 3.239-10.12-4.726-8.1zm-84.219 7.787l-7.844-.713-11.41 2.852-7.987-8.415-6.135-8.565 1.57-5.558 8.272 2.567 2.139-5.419 7.417.285 3.852-10.7 8.272-.285 4.279 11.267-1.569 7.84 8.557 2z"   transform="translate(-25.848 -22.537)"/>
                  <path name="서울" data-num="Seoul" d="M418.846 287.356l-4.279-11.267-8.272.285-3.851 10.7-7.417-.285-2.139 5.42-8.272-2.567-1.57 5.558 6.134 8.561 7.987 8.415 11.41-2.853 7.844.713 9.413-12.836-8.557-2z"   transform="translate(-31.356 -36.658)"/>
                  <path name="인천" data-num="Incheon" d="M358.956 294.155l3.032 11.585 3.542 5.8-1.992 7.89 8.062 12.456 5.865-13.991.921-10.223-7.143-10.733z"   transform="translate(-27.65 -39.441)"/>
                  <path name="강원도" data-num="Gangwon" d="M516.633 331.695l2.2-11.315 6.6-2.829 9.744 8.172 12.887-5.972 11.63 4.086 2.829 7.858h8.8l7.23 5.972h8.8l24.2 10.373 5.344-5.658-2.829-5.343 5.343-5.029 10.372 7.858 17.916 1.886 5.343-4.715 10.058 3.143 9.744-5.972 8.932-6.871-2.353-13.179-10.909-19.115L654.4 280.2v-9.71l-9.715-9.31v-7.286l-46.146-57.48-9.31-28.335-24.4-48.818-3.979 1.4-1.7 24.6-5.52 1.044-1.94 8.056-6.714 1.79-6.416 7.012-14.621.746-14.77.3-11.349-3.139h-17.9l-7.459 3.431-4.774-1.194-13.427-1.492-7.012 3.133-5.52-2.835-17.303 2.687-2.984 4.177-7.609 2.685-1.551 2.279 7.518 3.343 7.112 14.224 12.446-2.766 9.285 5.729 10.272.988 5.783 12.622 15.75 8.516.988 8.3-10.884 7.337 6.29 29.284 13.561 4.25 1.417 3.846 12.751 2.833.607 5.465-7.357 4.453 4.726 8.1-3.238 10.12-.4 16.192-3.648 6.3 5.977 8.622z"   transform="translate(-35.675 -12.492)"/>
                  <path name="충청남도" data-num="Chungnam" d="M374.315 524.621l8.266-6.337 17.082.551 3.582 5.786 11.572 2.48 14.052-4.133 10.746 17.358 15.429 1.653 11.573-8.266-6.062-9.368 1.1-12.95-10.746-6.062-7.439 6.888h-11.018l-11.3-12.674 2.48-17.634 11.572-15.43-13.226-18.736 8.542-17.909 7.99 2.755 1.653-5.786-15.341-16.935-14.168-9.918-14.573 5.465-14.064 3.166-4.551 8.075 1.464 8.414-4.243 6.855-3.934-.8-.448-12.234v-11.04l-4.177-7.161-5.669-.9-4.327-2.238-3.355 8.79-3.9-.319-1.841-7.576-6.242-7.932-5.7 4.434 3.289 5.587-5.52 8.5 1.343 6.564-2.686 1.94-2.835-5.371.433-10.133-4.625.448-8.442 11.424-3.479 9-16.36 2.709 2.634 12.956 11.04-1.194 6.564-6.266 4.177 5.669-.5 7.654 3.893.05 1.98-11.866 7.161.3v10.145l5.518 6.151-.717 3.506-8.083.488-.3 5.073 7.107 3.443v2.311l-5.465 4.839 5.147 10.139 8.366 3.506.213 5.3-9.25 1.79v3.285l8.205 1.79.035 3.451-9.083 8.366.694 11.755 14.173 5.52-.844 10.371 3.665 9.026 22.325-10.567z"   transform="translate(-18.018 -54.228)"/>
                  <path name="세종" data-num="Sejong" d="M435.207 466.484l-13.226-18.736 8.542-17.909 7.99 2.755 1.653-5.786-15.341-16.935-13.012 5.106-3.951 28.206z"   transform="translate(-18.018 -54.228)"/>
                  <path name="대전" data-num="Daejeon" d="M471.76 486.625l-13.6-6.189-11.572 15.43-2.48 17.634 11.3 12.674h11.021l7.439-6.888 5.247-23.365z"   transform="translate(-40.765 -68.14)"/>
                  <path name="충청북도" data-num="Chungbuk" d="M530.381 512.532l6.022-5.983-1-10.075-9.207 2.007-10.531-5.018 2.007-14.385 2.342-20.407-7.695-2.342-2.048-6.356 8.4-13.047 11.709-6.022 4.014-6.022 28.436-13.716 4.684 8.7 13.716-5.687-1.338-11.709 15.389-17.613 8.583-5.87-11.421-4.895h-8.8l-7.23-5.972h-8.8l-2.829-7.858-11.63-4.086-12.887 5.972-9.744-8.172-6.6 2.829-2.2 11.315h-15.4l-5.977-8.622-5.257 9.081-10.322 8.7-4.453 6.072h-11.538L453.6 399.747l-5.667 4.453 15.341 16.935-1.653 5.786-7.99-2.755-8.542 17.909 13.226 18.736 13.6 6.189 7.35 9.3-5.247 23.365 10.746 6.062-1.1 12.95 6.062 9.368L518 532.6z"   transform="translate(-40.837 -48.589)"/>
                  <path name="대구" data-num="Daegu" d="M617.243 620.281l-1.385-11.776 5.958-2.505 6.078 2.852 6.32-.693 3.279-9.5 8.621-11.918-3.933-9.058 4.333-8.04-12.2-6.8-12.223 7.076-7.475 6.722-7.7.3-6.645 9.053 4.849 10.044-5.2 24.244 3.81 5.2z"   transform="translate(-64.761 -80.823)"/>
                  <path name="울산" data-num="Ulsan" d="M729.353 650.186l11.807-13.808 1.166-14.257-22.477-3.521-11.776-6.312-14.2 15.664-6.339-1.3v14.978l11.006 4.815 9.287 9.286 16.593 15.139 4.857-3z"   transform="translate(-78.156 -88.444)"/>
                  <path name="부산" data-num="Busan" d="M706.935 667.183l-7.685 12.207-18.573 11.345-19.605 13.758 2.426 7.8.207 3.629 10.523-2.476-1.192-3.33 6.1-3.929 1.961 1.57-2.158 6.866 2.943 3.923 14.073-6.708 2.694-6.907 8.813-3.422 8.087-19.181 4.767-2.941z"   transform="translate(-74.166 -96.907)"/>
                  <path name="경상북도" data-num="Gyeongbuk" d="M722.619 558.073l.726-12.857 5.288-17.522-6-2.068-6.758 7.563-6.6 2.526-7.362-7.635 3-5.453V510.9l-2.727-5.181.274-20.719 4.635-3.272 3.272-22.632-4.908-7.635v-8.453l6.48-8.725v-14.659l-4.562-10.844-3.013-21.47.378-11.084-5.352-7.6-.546-3.06-8.932 6.871-9.744 5.972-10.058-3.149-5.343 4.715-17.916-1.886-10.372-7.858-5.343 5.029 2.829 5.343-5.344 5.658-12.782-5.478-8.582 5.87-15.389 17.613 1.338 11.709-13.716 5.687-4.684-8.7-28.436 13.718-4.015 6.022-11.709 6.022-8.4 13.047 2.048 6.356 7.695 2.342-2.342 20.407-2.007 14.385 10.531 5.018 9.207-2.007 1 10.075-6.022 5.983-12.379 20.07 1.786 18.551L547 560.227l12.122-1.039L567.436 574l-1.736 13.588 22.166 2.078 5.2-24.244-4.849-10.044 6.645-9.053 7.7-.3 7.475-6.722 12.223-7.076 12.2 6.8-4.333 8.04 3.933 9.058-8.621 11.918-3.279 9.5-6.32.693-6.078-2.852-5.958 2.506 1.385 11.776 7.273 5.2 19.742-.346 14.893-.346 7.619-7.273 13.507 2.771 14.2-15.672 11.776 6.312 22.477 3.517L718 567.617z" transform="translate(-52.505 -50.334)"/>
                  <path name="경상남도" data-num="Gyeongnam" d="M676.481 651.866l-9.287-9.286-11.007-4.815v-14.977l-7.169-1.471-7.619 7.273-14.893.346-19.742.346-7.273-5.2-13.507 5.2-3.81-5.2-22.166-2.078 1.732-13.586-8.312-14.815-12.122 1.039-15.239-7.273-18.393 3.406-16.195 17.832-5.944 26.193 12.437 20-8.6 15.985v16.165l19.816 16.85 1.57 17 13.9 2.132 4.8-6.021 9.027-.437V712l2.859-7 5.021-2.545 1.036 2.629-2.789 4.462-.17 14.172 15.069 7.107 3.568-6.627 4.419-.1 2.69 4.323 4.241-1.448 1.063-4.727 3.38.681 1.606 7.381 5.959.084 2.324-5.915-3.105-3.523 4.044-5.391 6.279-.771-1.2-5.865-8.415 1.549-1.564 4.324-3.139-1.569 1.288-5.7 8.81-2.476 1.223-5.486 10.062.907 7.6 6.8 2.4-3.553-6.078-5.992.051-5.283-4.977-2.9 4.337-6.92 3.439 1.425-1.762 4.666 17.833 11.923 10.369-.726-2.426-7.8 19.605-13.758 18.573-11.345 7.685-12.207z"   transform="translate(-47.009 -84.525)"/>
                  <path name="전라북도" data-num="Jeonbuk" d="M340.746 661.639l13.758-1.715 10.663-7.9v-10.678l11.35-4.127 11.006 14.8 13.758-1.388 3.783 13.07h35.083l8.943-7.911 15.822 7.911 8.6-15.985-12.437-20 5.944-26.188 16.192-17.828 18.389-3.4-1.786-18.551-28.284-4.564-11.573 8.266-15.429-1.653-10.746-17.358-14.052 4.133-11.572-2.48-3.582-5.786-17.082-.551-8.266 6.337.551 7.99-22.325 10.567-5.879 7.7 8.668 7.576 4.621-4.223 10.3-1.476-2.129 5.462-8.044 1.854-2.751 3.961 8.636 4.811-.931 5.589-14.9 3.061-21.956 14.371 4.391 8.649 3.194-2.795h13.307l4.871 3.686-.879 5.1-5.456-2.129-16.5 3.593-8.117 10.16 9.75 4.566z"   transform="translate(-22.935 -77.525)"/>
                  <path name="전라남도" data-num="Jeonnam" d="M482.823 714.258L463.008 697.4v-16.161l-15.822-7.911-8.942 7.911h-35.083l-3.783-13.07-13.759 1.388-11.005-14.8-11.351 4.128v10.674l-10.662 7.9-13.758 1.714-3.1-15.478-9.743-4.563.4 11.075-10.756 13.7 1.969 13.625 11.044 15.7-6.564 16.968-.493 29.744 16.906 12.722-3.239 16.342-5.391 6.959-.441 8.553 3.653 3.282-.079 4.541-2.067 4.64 4.1 3.639-.278 6.7 9.593-2.309.787-8.872 6.91-7.383 10.415-6.051-.137-8.689 2.789-8.366h4.142l-.8 9.162.786 9.747 13.05 3.559 1.975-9.166 6.788-10.934 6.96-7.308 13.721-6.292 3.855-5.31-1.725-3.963 6.733-4.041 3.59 2.561 16.424-4.855.738-4.455-5.053-1.336.838-3.543 11.937.882 12.762-11.4 7.489.8 15.062-8.5zm-89.637-1.719h-8.756l-12.568 6.878-2.751-5.847-14.446-3.783-1.376-11.007 10.662-7.842 8.255 2.684 4.815-5.5h7.409l4.286 11.35 5.847 2.063z"   transform="translate(-21.033 -94.734)"/>
                  <path name="광주" data-num="Gwangju" d="M391.345 694.247h-7.408l-4.815 5.5-8.255-2.684-10.667 7.846 1.376 11.006 14.446 3.783 2.751 5.847 12.568-6.879h8.759l1.376-11.006-5.847-2.064z"   transform="translate(-27.837 -101.096)"/>                  
                  <path name="제주" data-num="Jeju" d="M418.544 891.071l-32.915 1.611-15.652 7.826H356.4l-16.573 20.485 11.273 17.033h11.739l7.366-6.445 18.644.69 13.81-5.294 17.493-6.445 9.9-16.572z"   transform="translate(-24.786 -131.406)"/>
                </g>
              </svg>
            </div>

            <div id="Gyeonggi" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_31"><em class="en">ALL</em></p>
                <p class="province">경기도</p>
               	<span class="num" id="num_31">0</span>
                <ul class="buisList" id="card_31"></ul>
              </div>
            </div>
            
            <div id="Seoul" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_11"><em class="en">ALL</em></p>
                <p class="province">서울</p>
               	<span class="num" id="num_11">0</span>
                <ul class="buisList" id="card_11"></ul>
              </div>
            </div>
            
            <div id="Incheon" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_23"><em class="en">ALL</em></p>
                <p class="province">인천</p>
                <span class="num" id="num_23">0</span>
                 <ul class="buisList" id="card_23"></ul>
              </div>
            </div>
            
            <div id="Gangwon" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_32"><em class="en">ALL</em></p>
                <p class="province">강원도</p>
                <span class="num" id="num_32">0</span>
                <ul class="buisList" id="card_32"></ul>
              </div>
            </div>
            
            <div id="Chungnam" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_34"><em class="en">ALL</em></p>
                <p class="province">충청남도</p>
                <span class="num" id="num_34">0</span>
                <ul class="buisList" id="card_34"></ul>
              </div>
            </div>
            
            <div id="Sejong" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_29"><em class="en">ALL</em></p>
                <p class="province">세종</p>
                <span class="num" id="num_29">0</span>
                <ul class="buisList" id="card_29"></ul>
              </div>
            </div>
            
            <div id="Daejeon" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_25"><em class="en">ALL</em></p>
                <p class="province">대전</p>
                <span class="num" id="num_25">0</span>
                <ul class="buisList" id="card_25"></ul>
              </div>
            </div>
            
            <div id="Chungbuk" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_33"><em class="en">ALL</em></p>
                <p class="province">충청북도</p>
                <span class="num" id="num_33">0</span>
                <ul class="buisList" id="card_33"></ul>
              </div>
            </div>
            
            <div id="Daegu" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_22"><em class="en">ALL</em></p>
                <p class="province">대구</p>
                <span class="num" id="num_22">0</span>
                <ul class="buisList" id="card_22"></ul>
              </div>
            </div>
            
            <div id="Ulsan" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_26"><em class="en">ALL</em></p>
                <p class="province">울산</p>
                <span class="num" id="num_26">0</span>
                <ul class="buisList" id="card_26"></ul>
              </div>
            </div>
            
            <div id="Busan" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_21"><em class="en">ALL</em></p>
                <p class="province">부산</p>
                <span class="num" id="num_21">0</span>
				<ul class="buisList" id="card_21"></ul>
              </div>
            </div>
            
            <div id="Gyeongbuk" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
               <p class="cardTitle" id="title_37"><em class="en">ALL</em></p>
                <p class="province">경상북도</p>
                <span class="num" id="num_37">0</span>
                <ul class="buisList" id="card_37"></ul>
              </div>
            </div>
            
            <div id="Gyeongnam" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_38"><em class="en">ALL</em></p>
                <p class="province">경상남도</p>
                <span class="num" id="num_38">0</span>
                <ul class="buisList" id="card_38"></ul>
              </div>
            </div>
            
            <div id="Jeonbuk" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_35"><em class="en">ALL</em></p>
                <p class="province">전라북도</p>
                <span class="num" id="num_35">0</span>
               	<ul class="buisList" id="card_35"></ul>
              </div>
            </div>
            
            <div id="Jeonnam" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_36"><em class="en">ALL</em></p>
                <p class="province">전라남도</p>
                <span class="num" id="num_36">0</span>
               	<ul class="buisList" id="card_36"></ul>
              </div>
            </div>
            
            <div id="Gwangju" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_24"><em class="en">ALL</em></p>
                <p class="province">광주</p>
                <span class="num" id="num_24">0</span>
				<ul class="buisList" id="card_24"></ul>
              </div>
            </div>
            
            <div id="Jeju" class="mapCard">
              <div class="header">
                <h1>기업지도</h1>
                <button class="btn_close">닫기</button>
              </div>
              <div class="provinceWrap">
                <p class="cardTitle" id="title_39"><em class="en">ALL</em></p>
                <p class="province">제주도</p>
                <span class="num" id="num_39">0</span>
                <ul class="buisList" id="card_39"></ul>
              </div>
            </div>
          </div>
          <script>
            $(function () {
              $('path').on({
                click: function() {
                  var idx = $(this).attr('data-num');
                  $('.mapCard').css({'display':'none'});
                  $(document.body).css({'overflow': 'hidden'});

                  if ($('path').hasClass('on')) {
                    $('path, .prov, .prov em, .prov span').removeClass('on');
                  }
                  $(this).addClass('on');

                  if ($('#' + idx + '.mapCard').css('display') == 'none') {
                    $('#' + idx + '.mapCard').fadeIn();
                    $('.' + idx).addClass('on');
                    $('.' + idx).addClass('on');
                  }
                },
                mouseover: function() {
                  var idx = $(this).attr('data-num');
                  $('.prov').each(function() {
                    if ($(this).attr('data-num') == idx) {
                      $(this).find('span').addClass('on');
                      return false;
                    };
                  });
                },
                mouseleave: function() {
                  var idx = $(this).attr('data-num');
                  $('.prov').each(function() {
                    if ($(this).attr('data-num') == idx) {
                      $(this).find('span').removeClass('on');
                      return false;
                    };
                  });
                }
              });
              $('.btn_close').on('click', function () {
                $('.mapCard').css({'display':'none'});
                // $('.mask').css({'display':'none'});
                $(document.body).css({'overflow': 'auto'});
              });
            });
          </script>
        </div>
        
        <div id="tab02" class="js-tabcontent">
          <div class="bsMap pgt">
            <span class="resultTxt" id="search_count_tab02"></span>

            <table class="tbl cop">
              <caption><span>태양광산업 일자리 목록 보기</span></caption>
              <colgroup>
                <col style="width:20%">
                <col style="width:20%">
                <col style="width:20%">
                <col style="width:40%">
              </colgroup>
              <thead>
                <tr>
                  <th scope="col">가입유형</th>
                  <th scope="col">지역1</th>
                  <th scope="col">지역2</th>
                  <th scope="col">회사명</th>
                </tr>
              </thead>
              <tbody id="list_body"></tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  
  
<div class="mask"></div>
<div class="popup" id="detail_popup">
    <div class="wrap">
      <div class="header">
        <h1>기업정보</h1>
      </div>

      <div class="contents">
        <div class="bizTitle">
          <h2 id="company_name"></h2>
          <p class="summary" id="company_category"></p>
        </div>
        <div class="bizInfo" id="company_info">
        </div>
        <div class="relWrap" id="relative_job">
        </div>
      </div>
      <button class="_close">닫기</button>
    </div>
  </div>


<div id="job_detail_popup" class="popup">
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
      <button class="_close">닫기</button>
    </div>
  </div>


<script>
  $(function() {
    $('.btn_close').on('click', function() {
      $('.mask').css({'display':'none'});
      $('.popup').css({'display':'none'});
      $(document.body).css({'position':'unset','overflow': 'auto'});
    });
    
    $('._close').on('click', function () {
        var id = $(this).parent('div').parent('div').attr('id');
        $('#' + id).css({'display':'none'});
    });
  });
</script>
