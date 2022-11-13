import React from "react";
import { Box, CssBaseline, Stack } from "@mui/material";
import Navbar from './Navbar' 
import Sidebar from "./Sidebar";
import { Outlet } from "react-router-dom";
import { useState, useEffect } from "react";
import { useAppContext } from "../AppContext";

const Dashboard = () => {
    const { showSidebar,handleSidebar} = useAppContext();
    const [feedMarginTop,setFeedMarginTop] = useState('5%');
    const [feedMarginLeft,setFeedMarginLeft] = useState('10%');
    const [feedMarginRight,setFeedMarginRight] = useState('5%');

    useEffect(() => {    
        if (showSidebar) {
            setFeedMarginLeft('15%');
        }
        else {
            setFeedMarginLeft('10%');
        }
      }, [showSidebar])
    return (
        <div className="App">
            <CssBaseline />
            <Box>
                <Sidebar />
                <Navbar />
                <section className="Modulos">
                <Box
                    sx={{ marginLeft: feedMarginLeft, marginTop: feedMarginTop, marginRight: feedMarginRight }}
                >
                   <Outlet/>
                </Box>
                </section>
            </Box>
        </div>
    );
}

export default Dashboard;