import { React,useState, useEffect } from "react";
import axios from "axios";
import { useAppContext } from "../../AppContext";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";


const GraficoBarra = (props) =>{

const [options, setOptions] = useState({
  chart: {
    id: props.idChart
  },
  xaxis: {
    categories: [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999]
  }
});


const [series,setSeries] = useState([{
  name: 'series-1',
  data: [30, 40, 35, 50, 49, 60, 70, 91, 125]
}]);

    return (
      
      <Chart options={options} series={series} type="bar" width={500} height={320}/>   
      );
}

export default GraficoBarra;