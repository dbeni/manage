import React from 'react';
import { connect } from 'react-redux';

const Home = props => (
    <div>
        <h1>Employees management!</h1>
        <p>Small demo exercise for 2bePrecise!</p>
    </div>
);

export default connect()(Home);
