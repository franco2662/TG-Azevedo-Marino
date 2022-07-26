import React from "react";
import { AppBar, Toolbar, styled, Typography, Box, InputBase, Badge, Grid } from "@mui/material";
import NotificationsIcon from '@mui/icons-material/Notifications';
const StyledToolbar = styled(Toolbar)({
    display: "flex",
    justifyContent: "space-between"
})
const Search = styled("div")(({ theme }) => ({
    backgroundColor: "white",
    padding: "0 10px",
    borderRadius: theme.shape.borderRadius,
    width: "40%"
}))
const Icons = styled(Box)(({ theme }) => ({
}))
const Navbar = () => {
    return (
        <AppBar position="sticky">
            <StyledToolbar>
                <Typography variant="h6">Dashboard</Typography>
                <Search sx={{ display: { xs: "none", sm: "block" } }} ><InputBase placeholder="search..." /></Search>
                <Toolbar display="flex">
                    
                    <Icons ><Badge badgeContent={4} color="error">
                        <NotificationsIcon/>
                    </Badge></Icons>
                </Toolbar>
            </StyledToolbar>
        </AppBar>
    )
}
export default Navbar;