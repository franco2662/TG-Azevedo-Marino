import { Box } from "@mui/material";
import React from "react";
import { useState, useEffect } from "react";
import { useAppContext } from "../AppContext";

const Feed = () =>{
    const { showSidebar,handleSidebar} = useAppContext();
    const [feedMarginTop,setFeedMarginTop] = useState('5%');
    const [feedMarginLeft,setFeedMarginLeft] = useState('10%');

    useEffect(() => {    
        if (showSidebar) {
            setFeedMarginLeft('15%');
        }
        else {
            setFeedMarginLeft('10%');
        }
      }, [showSidebar])
    return(
        <Box 
        flex={4}
        sx ={{marginLeft:feedMarginLeft,marginTop:feedMarginTop}}
        >
            Feed
        </Box>
    )
}

export default Feed;