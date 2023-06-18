import { React,useState, useEffect } from "react";
import axios from "axios";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import { useAppContext } from "../../../AppContext";
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import NoElements from '../../../assets/no_elements.png'
import { Typography } from "@mui/material";


const CantProcs = (props) =>{

const {baseURL} = useAppContext();
const instance = axios.create()
instance.defaults.baseURL = baseURL;
const tipo_array = [{'categoria': 'procesos', 'No Deseados': 0, 'Prob No Deseados': 0}]
const[lista,setLista] = useState(tipo_array);
const[cargado,setCargado] = useState(false);


const [options, setOptions] = useState({
    chart: {
      type: 'donut',
    },
    labels: ['No Deseados', 'Prob No Deseados'],
    title: {
      text: 'Cantidad de Procesos'
    },
    colors: ['#991111', '#DBAD23'],
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
  setSeries([lista['No Deseados'],lista['Prob No Deseados']])
  setCargado(true);
}

const reporte = () =>{
  if (series[0] == undefined || (series[0]+series[1]==0)) {
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
        <Typography variant="h6" sx ={{marginTop:2, marginLeft:2,fontSize:'14px',fontWeight:'bold',fontFamily: 'Helvetica, Arial, sans-serif'}}>Cantidad de Procesos</Typography>
          <CardContent>
          <img src={NoElements} />
          </CardContent>
        </Card>
        );
    }    
  }
  else
  return (
    <Card sx={{ minWidth:500,minHeight:400,marginBottom:5,marginRight:2, borderRadius: 5 }} elevation={8}>
      <CardContent>
        <Chart redraw="true" options={options} series={series} type="pie" width={500} height={400} />
      </CardContent>
    </Card>
  );
}

useEffect(() => {   
    async function getListCantProcs(){
        try {
          const response = await instance.get("countProcs/"+props.id);
          setLista(JSON.parse(response.data));
        } catch (error) {
          console.log(error);
          throw new Error(error);
        } finally {   
        }      
        setChartConfig();
      };
      getListCantProcs();  
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

export default CantProcs;