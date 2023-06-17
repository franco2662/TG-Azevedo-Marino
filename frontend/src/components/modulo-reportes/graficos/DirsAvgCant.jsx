import { React,useState, useEffect } from "react";
import axios from "axios";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import { useAppContext } from "../../../AppContext";
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import NoElements from '../../../assets/no_elements.png'
import { Typography } from "@mui/material";


const DirsAvgCant = (props) =>{

const {baseURL} = useAppContext();
const instance = axios.create()
instance.defaults.baseURL = baseURL;
const tipo_array = [{'proceso': '', 'cantidad': 0, 'porcentaje': 0.00}]
const[lista,setLista] = useState(tipo_array);
const[cargando,setCargando] = useState(true);


const [options, setOptions] = useState({});
   
  
  const [series,setSeries] = useState([]);

const setChartConfig = () =>{
  let data_serie = [];
  let data_label = [];
  lista.map((item) => {
    data_label.push(item["directorio"]);
    data_serie.push(item["cantidad"]);
  }
  );
  setOptions({
    chart: {
      type: 'donut',
    },
    labels:data_label,
    title: {
      text: 'Cantidad de Reincidencia en Directorios'
    },
    plotOptions: {
      donut: {
        distributed: true,
        dataLabels: {
          position: 'bottom'
        },
      }
    },
    fill: {
      type: 'gradient',
    },
    legend: {
      position: 'bottom'
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
  })
  setSeries(data_serie);
}

const reporte = () =>{
  if (cargando || (lista.length==0)) {
    if(cargando){
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
        <Typography variant="h6" sx ={{marginTop:2, marginLeft:2,fontSize:'14px',fontWeight:'bold',fontFamily: 'Helvetica, Arial, sans-serif'}}>Cantidad de Reincidencia Directorios</Typography>
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
        <Chart redraw="true" options={options} series={series} type="donut" width={500} height={400} />
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
          setCargando(false);  
        }      
        setChartConfig();
      };
    getDirsAvg();  
  }, [props.id]);

  
  useEffect(() => {   
    setChartConfig();
    setCargando(false);
  }, [lista]);

    return (
        <>
        {reporte()}
        </>
      );
}

export default DirsAvgCant;