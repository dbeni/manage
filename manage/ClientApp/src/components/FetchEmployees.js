import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { actionCreators } from '../store/EmployeesStore';

class FetchEmployees extends Component {
    componentWillMount() {
        // This method runs when the component is first added to the page
        this.props.requestEmployeesList();
    }

    render() {
        return (
            <div>
                <h1>Employees List</h1>
                <p>List of all of the employees.</p>
                {this. renderEmployeesListTable(this.props)}       
            </div>
        );
    }
    
    renderEmployeesListTable(props) {
        return (
            <table className='table'>
                <thead>
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Position</th>
                        <th>Tools</th>
                    </tr>
                </thead>
            <tbody>
                {props.employeesList.map(
                    employeeObj =>
                        <tr key={employeeObj.idEmployee}>
                            <td>{employeeObj.firstName}</td>
                            <td>{employeeObj.lastName}</td>
                            <td>{employeeObj.position}</td>
                            <td><Link className='btn btn-default' to={`/detailsemployee/${employeeObj.idEmployee}`}>View</Link></td>
                        </tr>
                )}
            </tbody>
            </table>
        );
    }
}




export default connect(
    state => state.employeesStore,
  dispatch => bindActionCreators(actionCreators, dispatch)
)(FetchEmployees);
