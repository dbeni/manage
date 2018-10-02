const requestEmployeesListType = 'REQUEST_EMPLOYEES_LIST';
const receiveEmployeesListType = 'RECEIVE_EMPLOYEES_LIST';

const requestEmployeeDetailsType = 'REQUEST_EMPLOYEE_DETAILS';
const receiveEmployeeDetailsType = 'RECEIVE_EMPLOYEE_DETAILS';

const requestSaveReportType = 'REQUEST_SAVE_REPORT';
const receiveSaveReportType = 'RECEIVE_SAVE_REPORT';

const requestSaveTaskType = 'REQUEST_SAVE_TASK';
const receiveSaveTaskType = 'RECEIVE_SAVE_TASK';

const initialState = {
    employeesList: [],
    employeeDetails: [],
    
    reportsList: [],
    tasksList: [],
    isLoading: false
};

export const actionCreators = {
    requestEmployeesList: () => async (dispatch, getState) => {    
    
        dispatch({ type: requestEmployeesListType});

        const url = `api/Employee/Index`;
        const response = await fetch(url);
        const employeesList = await response.json();

        dispatch({ type: receiveEmployeesListType, employeesList });
    },

    requestEmployeeDetails: id => async (dispatch, getState) => {
        if (id === getState().employeesStore.id) {
            // Don't issue a duplicate request (we already have or are loading the requested data)
            return;
        }

        dispatch({ type: requestEmployeeDetailsType, id });

        const url = `api/Employee/Details/${id}`;
        const response = await fetch(url);
        const employeeDetails = await response.json();

        dispatch({ type: receiveEmployeeDetailsType, id, employeeDetails });
    },

    requestSaveReport: reportObject => async (dispatch, getState) => {
        dispatch({ type: requestSaveReportType, reportObject });

        const url = `api/Employee/Report`;
        const settings = {
            method: 'POST',
            headers: {
                Accept: 'application/json',
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(reportObject)
        };
        const response = await fetch(url, settings);
        const reportsList = await response.json();

        dispatch({ type: receiveSaveReportType, reportObject, reportsList });
    },

    requestSaveTask: taskObject => async (dispatch, getState) => {
        dispatch({ type: requestSaveTaskType, taskObject });

        const url = `api/Employee/Task`;
        const settings = {
            method: 'POST',
            headers: {
                Accept: 'application/json',
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(taskObject)
        };
        const response = await fetch(url, settings);
        const tasksList = await response.json();

        dispatch({ type: receiveSaveTaskType, taskObject, tasksList });
    }
};

export const reducer = (state, action) => {
  state = state || initialState;
    console.log(action);
    if (action.type === requestEmployeesListType) {
    return {
      ...state,
      isLoading: true
    };
  }

    if (action.type === receiveEmployeesListType) {
    return {
      ...state,
        employeesList: action.employeesList,
      isLoading: false
    };
  }

    if (action.type === requestEmployeeDetailsType) {
        return {
            ...state,
            id: action.id,
            isLoading: true
        };
    }

    if (action.type === receiveEmployeeDetailsType) {
        return {
            ...state,
            id: action.id,
            employeeDetails: action.employeeDetails,
            isLoading: false
        };
    }

    if (action.type === requestSaveReportType) {
        return {
            ...state,
            reportObject: action.reportObject,
            isLoading: true
        };
    }

    if (action.type === receiveSaveReportType) {
        return {
            ...state,
            reportObject: action.reportObject,
            reportsList: action.reportsList,
            isLoading: false
        };
    }

    if (action.type === requestSaveTaskType) {
        return {
            ...state,
            taskObject: action.taskObject,
            isLoading: true
        };
    }

    if (action.type === receiveSaveTaskType) {
        return {
            ...state,
            taskObject: action.taskObject,
            tasksList: action.tasksList,
            isLoading: false
        };
    }
  return state;
};
