import { React,useState, useEffect } from "react";
import axios from "axios";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import { useAppContext } from "../../../AppContext";
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import NoElements from '../../../assets/no_elements.png'
import { Typography } from "@mui/material";


const DirsAvgPerc = (props) =>{

const {baseURL} = useAppContext();
const instance = axios.create()
instance.defaults.baseURL = baseURL;
const tipo_array = [{'proceso': '', 'id_tipo': 0, 'porcentaje': 0.00}]
const[lista,setLista] = useState(tipo_array);
const[cargado,setCargado] = useState(false);


const [options, setOptions] = useState({
  chart: {
    type: 'Bar',
    width:300
  },
  title: {
    text: 'Reincidencia en Directorios Promedio de Porcentajes'
  },
  plotOptions: {
    bar: {
      barHeight: '30%',
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
    data_serie.push({x:item["directorio"],y:item["promedio"]});
  }
  );
  setSeries([{name: 'promedio',data:data_serie,color:'#D6A3E7'}]);
  setCargado(true);
}

const reporte = () =>{
  if (series[0] == undefined || (lista.length==0)) {
    if(series[0] == undefined){
      return (
        <Card sx={{ minWidth:500,minHeight:400,marginBottom:5,marginRight:2, borderRadius: 5 }} elevation={8}>
          <CardContent>
            cargando chart
          </CardContent>
        </Card>
        );
    }
    else{
      return (
        <Card sx={{ minWidth:500,minHeight:400,marginBottom:5,marginRight:2, borderRadius: 5 }} elevation={8}>
        <Typography variant="h6" sx ={{marginTop:2, marginLeft:2,fontSize:'14px',fontWeight:'bold',fontFamily: 'Helvetica, Arial, sans-serif'}}>Reincidencia en Directorios Promedio de Porcentajes</Typography>
          <CardContent>
          <img src={NoElements} />
          </CardContent>
        </Card>
        );
    }    
  }
  else
  return (
    <Card sx={{ minWidth: 500, minHeight: 400, marginBottom: 5, marginRight: 2, borderRadius: 5  }} elevation={8}>
      <CardContent>
        <Chart redraw="true" options={options} series={series} type="bar" width={500} height={400} />
      </CardContent>
    </Card>
  );
}

useEffect(() => {   
  async function getDirsAvg(){
      try {
        const response = await instance.get("listBadDirsAvg/"+props.id);
        setLista(JSON.parse(response.data));
      } catch (error) {
        console.log(error);
        throw new Error(error);
      } finally {   
      }      
      setChartConfig();
  };
    getDirsAvg();
}, [props.id]);


  
useEffect(() => {   
  setChartConfig();
}, [lista]);

    return (
        <>
        {reporte()}
        </>
      );
}

export default DirsAvgPerc;