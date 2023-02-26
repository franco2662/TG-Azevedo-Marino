import { React,useState, useEffect } from "react";
import axios from "axios";
import Chart from 'react-apexcharts'
import { Container } from "@mui/system";
import { useAppContext } from "../../../AppContext";
import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';


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
  if (series[0] == undefined) {
    return (<>cargando chart</>);
  }
  return (
    <Card sx={{ minWidth: 275 }}>
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
  }, [cargado]);


    return (
        <>
        {reporte()}
        </>
      );
}

export default CantProcs;