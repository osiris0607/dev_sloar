<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

  
<script type='text/javascript'>

	var jobList = new Array();
	var futureRoad1 = "";
	var futureRoad2 = "";
	var futureRoad3 = "";
	var futureRoadChoiceNo = "";
	
	$(document).ready(function() {
		// 규모
		initsize();
		// 행정 구역 정보 
		getRegionList();
		// 해정 구역 정보 Click
	 	$("#region").change(function(){
	 		var regionId =  $("#region").val();
	 		regionChange(regionId);
		});
		// 회사명 TXT에서 Click
		$("#name").on("keydown", function(key) {
            //키의 코드가 13번일 경우 (13번은 엔터키)
            if (key.keyCode == 13) {
            	searchList(1);
            }
        });
		
		searchList(1);
	});

	function initsize() {
		str = "";
		var size = $("#size"); 
		size.empty();

		str += '<option value="">규모선택</option>';
		// License Category 별로 License Selector를 만든다.
       	<c:forEach items="${commonCode}" var="code">
			<c:if test="${code.master_id == 'M000014'}">
				str += '<option value="${code.detail_id}"><c:out value="${code.name}"></c:out></option>';
			</c:if>
		</c:forEach>
		size.append(str);
	}

	function getRegionList() {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/user/api/util/openapi/sgis/administrativeDistrict/all' />");
		comAjax.setCallback("getregionListCB");
		comAjax.ajax();
	}

	function getregionListCB(data) {
		var str = "";
		regionList = data.result;
		var region = $("#region"); 
		region.empty();

		str += "<option value=''>전체</option>";
		$.each(regionList, function(key, value) {
			if (value.master_id == "D000001") {
				str += "<option value=\"" + value.code + "\">" + value.addr + "</option>";
			}
		});
		region.append(str); 
	}

	function regionChange(regionId){
		var str = "";
		var regionDetail = $("#region_detail"); 
		regionDetail.empty();

		str += "<option value=''>전체</option>";
		$.each(regionList, function(key, value) {
			if (value.master_id == "D000002" && value.parent_id == regionId ) {
				str += "<option value=\"" + value.code + "\">" + value.addr + "</option>";
			}
		});
		
		regionDetail.append(str); 
	}
	

	function searchList(pageNo) {
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/admin/api/company/search/paging' />");
		comAjax.setCallback("searchListCB");
		comAjax.addParam("pageIndex", pageNo);
		comAjax.addParam("orderby", "REGION_DETAIL ASC");

		comAjax.addParam("size", $("#size").val());
		comAjax.addParam("region", $("#region").val());
		comAjax.addParam("region_detail", $("#region_detail").val());
		comAjax.addParam("name", $("#name").val());
		comAjax.ajax();
	}


	function searchListCB(data) {
		var total = data.totalCount;
		var body = $("#list_body");
		body.empty();
		if (total == 0) {
			var str = "<tr>" + "<td colspan='8'>조회된 결과가 없습니다.</td>" + "</tr>";
			body.append(str);
		} else {
			var params = {
					divId : "pageNavi",
					pageIndex : "pageIndex",
					totalCount : total,
					eventName : "searchList"
				};

			gfnRenderPaging(params);

			$("#search_count").text(total);
			var index = 1;
			var str = "";
			$.each(data.result, function(key, value) {
				str += "<tr>";
				str += "	<td>" + index + "</td>";
				str += "	<td>"+ value.size_name + "</td>";
				str += "	<td>"+ value.region_name + "</td>";
				str += "	<td>"+ value.region_detail_name + "</td>";
				str += "	<td><a href='/admin/rdt/company/detail?company_id=" + value.company_id + "'>" + value.name + "</a></td>";
				str += "	<td>"+ value.ksic_name + "</td>";
				str += "	<td>"+ value.staff_number +"</td>";
				str += "	<td>"+ value.main_product +"</td>";
				str += "</tr>";

				index++;
			});
			body.append(str);
		}
	}

	function downloadExcelFile() {
		if (confirm('기업 정보를 다운로드합니다. 기업 정보가 많으면 다소 시간이 걸릴 수도 있습니다. 다운로드하시겠습니까?')) {
			var queryString = "?size=" + $("#size").val() + 
							 	"&region=" + $("#region").val() +
							 	"&region_detail=" + $("#region_detail").val();
			location.href = "/admin/api/company/excelDownload" + queryString;
		}
	}

</script>
  

<!--페이지 루트-->
<div class="page-nation container">
    <a  href="./html/index.html"><i class="nav-icon fa fa-home mr5"></i>홈화면</a><span class="route_icon"></span>
    <a href="/admin/rdt/company/searchList">기업 관리</a><span class="route_icon"></span>
    <a href="javascript:void(0);">기업 검색</a>
</div>
<!--본문시작-->
<div class="sub-container container">
	<div class="sub-content">
<!--페이지 타이틀-->				
		<div class="page-header">
			<h3 class="page-title text-primary-d2 text-120">기업 검색</h3>
		</div>
<!--리스트 검색 상단-->				
		<div class="sub-content-box bgc-white">
            <div class="bgc-secondary-l4 clearfix">
                <ul>
                    <li>
                        <div class="form-group row">                       
                            <div class="w10 fl col-form-label text-sm-right pr-0">
                              <label class="mb-0">업체 규모</label>
                            </div>
                            <div class="col-sm-9">
                                <select class="ace-select w40" id="size">
                                </select>
                            </div>
                        </div>                                
                    </li>
                    <li>
                       <div class="form-group row">
                           <div class="w10 fl col-form-label text-sm-right pr-0">
                           <label class="mb-0">지역</label>
                           </div> 
                           <div class="col-sm-9">
                            <select class="area_write_table_txt w40 ace-select" name="region" id="region" title="지역 선택">
							</select>
                            <select class="area_write_table_txt w52 ace-select" name="region_detail" id="region_detail" title="지역 선택">
                            	<option value=''>전체</option>
						 	</select>
                          </div>         
                       </div>                                
                    </li>
                    <li>
                      <div class="form-group row">        
                          <div class="w10 fl col-form-label text-sm-right">
                            <label class="mb-0">회사명</label>
                           </div>
                           <div class="col-sm-9">
                               <input type="text" class="form-control brc-on-focusd-inline-block" placeholder="회사명을 입력하세요" style="width:93%" id="name" />
                           </div>
                       </div>       
                   	</li>
                </ul>
                <div class="clearfix list_top_btn_box" style="float: right">
                    <button class="grean_btn fl" onclick='downloadExcelFile();'>엑셀 다운로드</button>
                    <button class="blue_btn2 fl ml5" onclick="searchList(1);">검색</button>
                </div>
            </div> 
             <!--리스트 상단 검색결과-->                
            <div class="list_search_end_box clearfix">
                <h4 class="fl">검색결과</h4>
                <span class="list_search_results fl ml10" id="search_count">0</span><em class="fl">개</em>
                <!-- <a href="./html/company-registration.html" class="blue_btn button fr ml10" >기업 등록</a> -->
                
                
                <!--리스트 상단 검색결과 테이블-->    
                <table class="table table-striped-primary table-borderless text-dark-m1 mb-0" id="responsive-table">
                  <colgroup>
		               <col style="width: 90px;" />
		               <col style="width: 90px;" />
		               <col style="width: 150px;" />
		               <col style="width: 170px;" />
		               <col style="width: 200px;" />
		               <col style="width: 200px;" />
		               <col style="width: 100px;" />
		               <col style="width: 280px;" />
             	  </colgroup>
                  <thead>
                    <tr class="bgc-primary-d2 text-white text-sm-center">
                      <th>순번</th>
                      <th>업체규모</th>
                      <th>지역1</th>
                      <th>지역2</th>
                      <th>회사명</th>
                      <th>표준산업분류</th>
                      <th>고용인수</th>
                      <th>주력제품/서비스</th>

                    </tr>
                  </thead>
                  <tbody class="bgc-primary-d2 text-sm-center" id="list_body"></tbody>
                </table> 
	             
	             <div class="Page_navigation">
					<div id="pageNavi"></div>
					<input type="hidden" id="pageIndex" name="pageIndex"/>
				</div>
	                  
        	</div>
        </div>
    </div>
</div>
