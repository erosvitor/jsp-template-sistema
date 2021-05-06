package com.ctseducare.template.json;

import java.util.List;

public class DatatableJson {

  private Integer draw;
  private Integer recordsTotal;
  private Integer recordsFiltered;
  @SuppressWarnings("rawtypes")
  private List data;
  private String error;

  public Integer getDraw() {
    return draw;
  }

  public void setDraw(Integer draw) {
    this.draw = draw;
  }

  public Integer getRecordsTotal() {
    return recordsTotal;
  }

  public void setRecordsTotal(Integer recordsTotal) {
    this.recordsTotal = recordsTotal;
  }

  public Integer getRecordsFiltered() {
    return recordsFiltered;
  }

  public void setRecordsFiltered(Integer recordsFiltered) {
    this.recordsFiltered = recordsFiltered;
  }

  @SuppressWarnings("rawtypes")
  public List getData() {
    return data;
  }

  @SuppressWarnings("rawtypes")
  public void setData(List data) {
    this.data = data;
  }

  public String getError() {
    return error;
  }

  public void setError(String error) {
    this.error = error;
  }

}
