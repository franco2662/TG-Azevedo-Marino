import { React,useState, useEffect } from "react";
import axios from "axios";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import { useAppContext } from "../../../AppContext";


const ProcsAvgPerc = (props) =>{

const {baseURL} = useAppContext();
const instance = axios.create()
instance.defaults.baseURL = baseURL;
const tipo_array = [{'proceso': '', 'id_tipo': 0, 'porcentaje': 0.00}]
const[lista,setLista] = useState(tipo_array);


const [options, setOptions] = useState({
  chart: {
    type: 'Bar',
    width:300
  },
  title: {
    text: 'Reincidencia en Procesos Promedio de Porcentajes'
  },
  plotOptions: {
    bar: {
      barHeight: '100%',
      distributed: false,
      horizontal: true,
      dataLabels: {
        position: 'bottom'
      },
    }
  },
  fill: {
    type: 'gradient',
  },
  responsive: [{
    breakpoint: undefined,
    options: {
      chart: {
        width: 200
      },
      fill: {
        type: 'gradient',
      },
      legend: {
        position: 'bottom'
      }
    }
  }]
});
 
const [series,setSeries] = useState([]);

const setChartConfig = () =>{
  let data_serie = [];
  lista.map((item) => {    
    data_serie.push({x:item["proceso"],y:item["promedio"]});
  }
  );
  setSeries([{name: 'promedio',data:data_serie,color:'#D6A3E7'}]);
}

const reporte = () =>{
       return(    
        <Chart redraw="true" options={options} series={series} type="bar" width={500} height={400}/>    
    );
}

useEffect(() => {   
  async function getProcsAvg(){
      try {
        const response = await instance.get("listBadProcsAvg/"+props.id);
        setLista(JSON.parse(response.data));
      } catch (error) {
        console.log(error);
        throw new Error(error);
      } finally {   
      }      
      setChartConfig();
    };
    getProcsAvg();  
}, [props.id]);


    return (
        <>
        {reporte()}
        </>
      );
}

export default ProcsAvgPerc;