<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type='text/javascript'>

	$(document).ready(function() {

		// 검색
		$("#search_btn").click(function() {
			searchList(1);
		});

		// 생태계 분류 Click
	 	$("#selector_category").change(function(){
		    categoryId =  $(this).val();
		    categoryChange(categoryId);
		});

		// 회사명 TXT에서 Click
		$("#search_text").on("keydown", function(key) {
            //키의 코드가 13번일 경우 (13번은 엔터키)
            if (key.keyCode == 13) {
            	searchList(1);
            }
        });
		
		selectorInit();
		ocurrpationInit();
		searchList(1);
	});

	function searchList(pageNo) {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/user/api/solar/job/search/paging' />");
		comAjax.setCallback("searchListCB");
		comAjax.addParam("pageIndex", pageNo);
		comAjax.addParam("orderby", "CATEGORY_ID, CATEGORY_DETAIL_ID");

		comAjax.addParam("category_id", $("#selector_category option:selected").val());
		comAjax.addParam("category_detail_id", $("#selector_category_detail option:selected").val());
		comAjax.addParam("occupation", $("#selector_ocurrpation option:selected").val());
		comAjax.addParam("name", $("#search_text").val());
		
		comAjax.ajax();
	}


	function searchListCB(data) {
		var total = data.totalCount;
		var body = $("#list_body");
		body.empty();
		if (total == 0) {
			var str = "조회된 결과가 없습니다.";
			body.append(str);
		} else {
			var params = {
				divId : "pageNavi",
				pageIndex : "pageIndex",
				totalCount : total,
				eventName : "searchList"
			};
			gfnRenderPagingMain(params);

			var str = "";
			$.each(data.result, function(key, value) {
				str += "<li>";
				str += "	<div class='jobTitlearea'><p class='jobTitle'>" + unescapeHtml(value.name) + "</p></div>";
				str += "	<dl>";
				str += "		<dt>코드분류</dt>";
				str += "			<dd>" + unescapeHtml(value.category_name) + "</dd>";
				str += "			<dd>" + unescapeHtml(value.category_detail_name) + "</dd>";
				str += "		<dt>직종</dt>";
				str += "			<dd>" + unescapeHtml(value.occupation_name) + "</dd>";
				str += "		<dt>학력</dt>";
				str += "			<dd>" + unescapeHtml(value.education_name) + "</dd>";
				str += "	</dl>";
				str += "	<a href='/user/rdt/solar/jobDictionary/detail?job_id=" + value.job_id + "'>상세보기 <i class='fa fa-angle-right' aria-hidden='true'></i></a>";
				str += "</li>";
			});
			body.append(str);
		}
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


	function ocurrpationInit() {
		str = "";
		var ocurrpation = $("#selector_ocurrpation"); 
		ocurrpation.empty();
		str += '<option value="">직종별</option>';
		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000004'}">
				str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
			</c:if>
		</c:forEach>
		ocurrpation.append(str); 
	}

	function selectorInit() {
 		var str = "";
		var category = $("#selector_category"); 
		category.empty();
		str += '<option value="">생태계 분류</option>';
		<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000002'}">
				str += '<option value="${code.detail_id}">${code.name}</option>';
			</c:if>
		</c:forEach>	
		category.append(str);
		
 		str = "";
		var categoryDetail = $("#selector_category_detail"); 
		categoryDetail.empty();
		str += '<option value="">생태계 세부</option>';
		categoryDetail.append(str); 
	}
	

</script>

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

      <fieldset>
        <legend><span>조건검색</span></legend>
        <ul class="searchWrap">
          <li>
            <select name="" id="selector_category">
            </select>
          </li>
          <li>
            <select name="" id="selector_category_detail">
            </select>
          </li>
          <li>
            <select name="" id="selector_ocurrpation">
            </select>
          </li>
          <li>
            <input type="text" placeholder="검색어" id="search_text">
          </li>
          <li>
            <button type="submit" id="search_btn">검색</button>
          </li>
          <li>
            <button type="button" class="dicBtn open">일자리 사전 용어가이드</button>
          </li>
        </ul>
      </fieldset>

      <ul class="jobCard" id="list_body"></ul>
    </div>

	<!-- pagination -->
	<input type="hidden" id="pageIndex" name="pageIndex"/>
    <div class="pagination" id="pageNavi">
    </div>
    
  </section>
</div>

  <!-- Layer -->
  <div class="mask"></div>

  <div class="popup">
    <div class="wrap">
      <div class="header">
        <h1>일자리 사전 용어 가이드</h1>
      </div>

      <div class="contents">
        <table class="tblDicGuide">
          <caption><span>용어 가이드 안내</span></caption>
          <colgroup>
            <col style="width:7%;">
            <col style="width:20%;">
            <col style="width:20%;">
            <col style="width:53%;">
          </colgroup>
          <thead>
            <tr>
              <th scope="col">번호</th>
              <th scope="col">대분류</th>
              <th scope="col">중분류</th>
              <th scope="col">항목정의</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>1</td>
              <td>직업</td>
              <td>직업명</td>
              <td>해당 직업의 명칭</td>
            </tr>
            <tr>
              <td>2</td>
              <td>기본정보</td>
              <td>일자리 정의</td>
              <td>해당 직업의 명칭</td>
            </tr>
            <tr>
              <td>3</td>
              <td rowspan="4">직무자격</td>
              <td>학력</td>
              <td>해당 직업을 갖는데 필요한 일반적인 학력 수준</td>
            </tr>
            <tr>
              <td>4</td>
              <td>전공</td>
              <td>해당 직업과 관련된 학과(전공)</td>
            </tr>
            <tr>
              <td>5</td>
              <td>자격증</td>
              <td>해당 직업을 갖는데 필요한 자격증(면허)</td>
            </tr>
            <tr>
              <td>6</td>
              <td>필요 경력</td>
              <td>해당 직업을 갖는데 필요한 경력기간</td>
            </tr>
            <tr>
              <td>7</td>
              <td>직무 난이도</td>
              <td>직무 난이도</td>
              <td>해당 직업의 난이도(지식, 기술전문성 수준 등)</td>
            </tr>
            <tr>
              <td>8</td>
              <td rowspan="3">직무능력</td>
              <td>지식</td>
              <td>학교, 학원, 직장 등을 통해서 습득 가능한 학문적 지식 또는 직무를 수행하는데 
                필요한 기초 이론적 지식을 의미</td>
            </tr>
            <tr>
              <td>9</td>
              <td>기술</td>
              <td>산업 현장에서 실무를 수행하는데 필요한 행동 능력 및 기술을 의미</td>
            </tr>
            <tr>
              <td>10</td>
              <td>태도</td>
              <td>직무를 수행함에 있어 필요한 기본 소양 및 마음가짐, 태도를 의미</td>
            </tr>
            <tr>
              <td>11</td>
              <td>근무여건</td>
              <td>급여수준</td>
              <td>종사자들의 일반적인 급여수준</td>
            </tr>
            <tr>
              <td>12</td>
              <td>일거리 전망</td>
              <td>일자리 전망</td>
              <td>일자리 유망성(전문가 의견 반영)</td>
            </tr>
            <tr>
              <td>13</td>
              <td rowspan="2">기타</td>
              <td>관련 직업 정보</td>
              <td>해당 직업과 관련 있는 타 직업 명칭</td>
            </tr>
            <tr>
              <td>14</td>
              <td>한국고용직업분류</td>
              <td>해당 직업과 매칭되는 한국고용직업분류(KECO)</td>
            </tr>
          </tbody>
        </table>
      </div>
      <button class="btn_close"><i class="fa fa-times" aria-hidden="true"></i></button>
    </div>
  </div>
  <script>
    $(function() {
      $('.open').on('click', function() {
        $('.mask').css({'display':'block'});
        $('.popup').css({'display':'block'});
        $(document.body).css({'position':'fixed','overflow': 'hidden'});
        var popHeight = $('.popup .wrap').height();
        if (popHeight > 800) {
          $('.popup .wrap').css({'height': '776px'}); //padding 값 24px 제외
          $('.popup .wrap .contents').css({'height': '722px'});
        } else {
          $('.popup .wrap').css({'height': popHeight});
        }
      });
      $('.btn_close').on('click', function() {
        $('.mask').css({'display':'none'});
        $('.popup').css({'display':'none'});
        $(document.body).css({'position':'unset','overflow': 'auto'});
      });
    });
  </script>