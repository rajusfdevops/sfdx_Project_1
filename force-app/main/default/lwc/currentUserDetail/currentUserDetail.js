import { LightningElement, wire } from 'lwc';
import USERID from '@salesforce/user/Id';
import USER_PROFILE_NAME from '@salesforce/schema/User.Profile.Name';
import USER_NAME from '@salesforce/schema/User.Name';
import USER_MANAGER_NAME from '@salesforce/schema/User.Manager.Name';
import USER_ROLE_NAME from '@salesforce/schema/User.UserRole.Name';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import hasPermission from '@salesforce/customPermission/AccessComponent';

export default class CurrentUserDetail extends LightningElement {
    UserName;
    userProfileName;
    userManagerName;
    userRoleName;
    hasAccess = false;

    @wire(getRecord, { recordId: USERID, fields: [USER_NAME, USER_PROFILE_NAME, USER_MANAGER_NAME, USER_ROLE_NAME] })
    userDetails({ error, data }) {
        if (data) {
            this.UserName = getFieldValue(data, USER_NAME);
            this.userProfileName = getFieldValue(data, USER_PROFILE_NAME);
            this.userManagerName = getFieldValue(data, USER_MANAGER_NAME);
            this.userRoleName = getFieldValue(data, USER_ROLE_NAME);
        } else if (error) {
            console.error(error);
        }
    }

    connectedCallback() {
        this.hasAccess = hasPermission;
    }

    get hasUserDetails() {
        return this.UserName && this.userProfileName && this.userManagerName && this.userRoleName;
    }
}