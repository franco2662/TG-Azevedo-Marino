import { React,useState, useEffect } from "react";
import axios from "axios";
import { useAppContext } from "../../AppContext";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";


const GraficoDonut = (props) =>{

const [options, setOptions] = useState({
  chart: {
    type: 'donut',
  },
  responsive: [{
    breakpoint: 480,
    options: {
      chart: {
        width: 200
      },
      legend: {
        position: 'bottom'
      }
    }
  }]
});


const [series,setSeries] = useState([44, 55, 41, 17, 15]);

    return (
      
      <Chart options={options} series={series} type="donut" width={500} height={320}/>
      );
}

export default GraficoDonut;