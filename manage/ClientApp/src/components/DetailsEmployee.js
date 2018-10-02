import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { actionCreators } from '../store/EmployeesStore';
import { Modal, Button } from 'react-bootstrap';
import DatePicker from 'react-date-picker';

class DetailsEmployees extends Component {
    constructor(props) {
        // Required step: always call the parent class' constructor
        super(props);

        let initDate = new Date();
        initDate.setUTCHours(5, 0, 0, 0);

        this.initDate = initDate;

        // Set the state directly. Use props if necessary.
        this.state = {
            employeeDetailsModal: null,
            employeeDetailsModalEmployee: null,
            reportContent: "",
            taskContent: "",
            taskDueDate: this.initDate,
        }
    }

    componentWillMount() {
        // This method runs when the component is first added to the page
        this.props.requestEmployeeDetails(this.props.match.params.id);
    }

    componentWillReceiveProps(nextProps) {
    // This method runs when incoming props (e.g., route params) change
        this.props.requestEmployeeDetails(this.props.match.params.id);
      }

    render() {
        return (
            <div>
                <h1>Employee Details</h1>
                {this.renderModal(this.props)}    
                {this.renderEmployeeGeneralInfo(this.props)}

                <div className="panel panel-default">
                    {this.renderEmployeeTaskList(this.props)}
                </div>

                <div className="panel panel-default">
                    {this.renderEmployeeManagedList(this.props)}
                </div>
            </div>
        );
    }

    renderEmployeeManagedList(props) {
        if (!props.employeeDetails.managerOf)
            return;

        let subordinatesContent = [];
        const managerOf = props.employeeDetails.managerOf;
        if (0 == managerOf.length) {
            return (
                <div className="container-fluid">
                    <div className="row">
                        <div className="col-md-12">
                            <label>My subordinates</label>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            No subordinates for this employee.
                        </div>
                    </div>
                </div>);
        }

        for (let i = 0; i < managerOf.length; i++) {
            subordinatesContent.push(
                <div className="row" key={'subordinate_'+i}>
                    <div className="col-md-6">
                        {managerOf[i].firstName} {managerOf[i].lastName}
                    </div>
                    <div className="col-md-3">
                        {managerOf[i].position}
                    </div>
                    <div className="col-md-3">
                        <Button onClick={this.displayModal.bind(this, 'Assign', managerOf[i])}>Assign Task</Button>
                    </div>
                </div>
            );

        }
        return (
            <div className="container-fluid">
                <div className="row">
                    <div className="col-md-12">
                        <label>My Subordinates</label>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-6">
                        <label>Names</label>
                    </div>
                    <div className="col-md-3">
                        <label>Position</label>
                    </div>
                    <div className="col-md-3">
                        <label>Tools</label>
                    </div>
                </div>
                {subordinatesContent}
            </div>
        );

    }

    renderEmployeeTaskList(props) {
        if (!props.employeeDetails.taskList)
            return;

        let taskListContent = [];
        const taskList = props.employeeDetails.taskList;
        if (0 == taskList.length) {
            return (
                <div className="container-fluid">
                    <div className="row">
                        <div className="col-md-12">
                            <label>My tasks</label>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-md-12">
                            No tasks defined for this employee.
                        </div>
                    </div>
                </div>);
        }

        for (let i = 0; i < taskList.length; i++) {
            taskListContent.push(
                <div className="row" key={'task_' + i}>
                    <div className="col-md-9">
                        {taskList[i].taskDescription}
                    </div>
                    <div className="col-md-3">
                        {taskList[i].dueDate}
                    </div>
                </div>
            );

        }
        return (
            <div className="container-fluid">
                <div className="row">
                    <div className="col-md-12">
                        <label>My tasks</label>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-9">
                        <label>Task Description</label>
                    </div>  
                    <div className="col-md-3">
                        <label>Due Date</label>
                    </div>
                </div>
                {taskListContent}
            </div>
        );


    }

    renderEmployeeGeneralInfo(props) {

        if (!props.employeeDetails.employee)
            return;

        return (
            <div className="panel panel-default">            
                <div className="container-fluid">
                    <div className="row">
                        <div className="col-md-3">
                            {props.employeeDetails.employee.picture ? <img src={props.employeeDetails.employee.picture} />: <img src='/images/unknown_user.png'/> }
                        </div>
                        <div className="col-md-9">
                            <div className="row">
                                <div className="col-md-3">
                                    <label>Name:</label>
                                </div>
                                <div className="col-md-9">
                                    {props.employeeDetails.employee.firstName} {props.employeeDetails.employee.lastName}
                                </div>
                            </div>
                            <div className="row">
                                <div className="col-md-3">
                                    <label>Position:</label>
                                </div>
                                <div className="col-md-9">
                                        {props.employeeDetails.employee.position}
                                </div>
                            </div>
                            {props.employeeDetails.managedBy && props.employeeDetails.managedBy.length != 0
                                ?
                                <div>
                                    <div className="row">
                                        <div className="col-md-12">
                                            <hr style={{ 'borderTop': '1px solid #303030' }} />
                                        </div>
                                    </div>
                                    <div className="row">
                                        <div className="col-md-3">
                                            <label>Manager:</label>
                                        </div>
                                        <div className="col-md-6">
                                            {props.employeeDetails.managedBy.firstName} {props.employeeDetails.managedBy.lastName}
                                        </div>
                                        <div className="col-md-3">
                                            <button onClick={this.displayModal.bind(this, 'Report', props.employeeDetails.managedBy)}>Report</button>
                                        </div>
                                    </div>
                                </div>
                                :
                                null
                                }
                        
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    isManager(employeeObj) {
        if (employeeObj.manager.length != 0) {
            return true;
        }
        return false;
    }

    displayModal(modalType, employee) {
        this.setState({
            employeeDetailsModal: modalType,
            employeeDetailsModalEmployee: employee
        });
    }

    renderModal(props) {
        if (!this.state.employeeDetailsModal) {
            return null;
        }

        if (this.state.employeeDetailsModal == 'Report') {
            return (
            <div className="static-modal">
                <Modal.Dialog>
                    <Modal.Header>
                            <Modal.Title>Report to Manager {props.employeeDetails.managedBy.firstName} {props.employeeDetails.managedBy.lastName}</Modal.Title>
                    </Modal.Header>

                        <Modal.Body>
                            <div className="form-group">
                                <div className="row">
                                    <div className="col-md-3">
                                        <label>Content:</label>
                                    </div>
                                    <div className="col-md-9">
                                        <textarea
                                            className="form-control"
                                            value={this.state.reportContent}
                                            onChange={this.setReport.bind(this)}></textarea>
                                    </div>
                                </div>
                            </div>
                        </Modal.Body>

                    <Modal.Footer>
                            <Button onClick={this.closeModal.bind(this)}>Cancel</Button>
                            <Button
                                bsStyle="primary"
                                onClick={this.saveReport.bind(this)}>Save Report</Button>
                    </Modal.Footer>
                </Modal.Dialog>
            </div>)
        }

        if (this.state.employeeDetailsModal == 'Assign') {
            return (
                <div className="static-modal">
                    <Modal.Dialog>
                        <Modal.Header>
                            <Modal.Title>Assign Task to {this.state.employeeDetailsModalEmployee.firstName} {this.state.employeeDetailsModalEmployee.lastName}</Modal.Title>
                        </Modal.Header>

                        <Modal.Body>
                            <div className="form-group">
                                <div className="row">
                                    <div className="col-md-3">
                                        <label>Task Content:</label>
                                    </div>
                                    <div className="col-md-9">
                                        <textarea
                                            className="form-control"
                                            value={this.state.taskContent}
                                            onChange={this.setTaskContent.bind(this)}></textarea>
                                    </div>
                                </div>
                                <div className="row">
                                    <div className="col-md-3">
                                        <label>Due Date:</label>
                                    </div>
                                    <div className="col-md-9">
                                        <DatePicker
                                            onChange={this.setTaskDueDate.bind(this)}
                                            value={this.state.taskDueDate}
                                        />
                                    </div>
                                </div>
                            </div>
                        </Modal.Body>

                        <Modal.Footer>
                            <Button onClick={this.closeModal.bind(this)}>Cancel</Button>
                            <Button
                                bsStyle="primary"
                                onClick={this.saveTask.bind(this)}>Save Task</Button>
                        </Modal.Footer>
                    </Modal.Dialog>
                </div>)
        }
    }

    setReport(e) {
        this.setState({ reportContent: e.target.value });
    }

    setTaskContent(e) {
        this.setState({ taskContent: e.target.value });
    }

    setTaskDueDate(e) {
        this.setState({ taskDueDate: e});
    }

    saveReport() {
        this.props.requestSaveReport(
            { IdReportCreator: this.props.employeeDetails.employee.idEmployee, ReportContent: this.state.reportContent }
        ).then((response) => {
            alert("Report correctly saved");
            this.closeModal();
            });
    }

    saveTask() {
        this.props.requestSaveTask(
            {
                IdTaskCreator: this.props.employeeDetails.employee.idEmployee,
                TaskAssignee: this.state.employeeDetailsModalEmployee.idEmployee,
                TaskDescription: this.state.taskContent,
                DueDate: this.state.taskDueDate,
            }
        ).then((response) => {
            alert("Task correctly saved");
            this.closeModal();
        });
    }

    closeModal() {
        this.setState({
            reportContent: "",
            employeeDetailsModal: null,
            employeeDetailsModalEmployee: null,
            taskContent: "",
            taskDueDate: this.initDate,
        });
    }
}




export default connect(
    state => state.employeesStore,
    dispatch => bindActionCreators(actionCreators, dispatch)
)(DetailsEmployees);
