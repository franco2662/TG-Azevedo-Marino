import { React,useState, useEffect, useRef } from "react";
import axios from "axios";
import { useAppContext } from "../../AppContext";
import { Container } from "@mui/system";
import { useNavigate } from "react-router-dom";
import { Button, Input, Typography } from "@mui/material";
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
} from '@mui/material';

const ModuloHistorial = () => {
    const { usuarioObjeto, baseURL,idAnalisisFromHistory } = useAppContext();
    const instance = axios.create()
    instance.defaults.baseURL = baseURL;
    instance.defaults.timeout = 3600;
    const navigate = useNavigate();
    const [historial,setHistorial] = useState([])
    
    const tableStyle = {
        border: "1px solid #ccc",
        borderRadius: "8px",
        boxShadow: "0px 2px 10px rgba(0, 0, 0, 0.1)",
      };
      const headerCellStyle = {
        fontSize: "18px",
        fontWeight: 600,
      };


    useEffect(() => {   
        async function getHistorial(){
          if(usuarioObjeto.current.id=="")return;
          try {
            const response = await instance.get("analisisHistory/"+usuarioObjeto.current.id);
            setHistorial(JSON.parse(response.data));
          } catch (error) {
          } finally {      
          }          
          return true;
        };     
        getHistorial();
      }, []);

      const handleRowDoubleClick = (idAnalisis) => {        
        idAnalisisFromHistory.current=idAnalisis
        navigate('/dashboard');
      };

    return (
        <Container>
            <Typography variant="h4" gutterBottom>
                Historial de Análisis
            </Typography>
            <TableContainer component={Paper} sx={{marginTop:10,...tableStyle}}>
                <Table size="small" aria-label="a dense table" sx={{ minWidth: 650 }}>
                    <TableHead>
                        <TableRow>
                            <TableCell colSpan={2} align="center" sx={headerCellStyle}>ID de análisis</TableCell>
                            <TableCell align="right" sx={headerCellStyle}>Nombre de PC</TableCell>
                            <TableCell align="right" sx={headerCellStyle}>Fecha</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {historial.map((row) => (
                            <TableRow key={row.id_analisis} onDoubleClick={() => handleRowDoubleClick(row.id_analisis)}>
                                <TableCell align="right">
                                    <Button
                                        variant="contained"
                                        color="primary"
                                        onClick={() => handleRowDoubleClick(row.id_analisis)}
                                        sx={{
                                            backgroundColor: '#453FC6', borderRadius: 2, ":hover": {
                                              bgcolor: "#3530a1",
                                              color: "white"
                                            }
                                          }}
                                    >
                                        Ver análisis
                                    </Button>
                                </TableCell>
                                <TableCell component="th" scope="row">
                                    {row.id_analisis}
                                </TableCell>
                                <TableCell align="right">{row.nombre_pc}</TableCell>
                                <TableCell align="right">{row.fecha}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </TableContainer>
        </Container>
    );
}
  
  export default ModuloHistorial;