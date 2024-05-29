package com.syndic.beans;

public class Reclamation {

        private int reclaimId;
        private String reclaimType;
        private String date;
        private String reclaimDescription;
        private String reclaimStatus;
        private String reclaimResolutionDate; // Using String for dates
        private int reclaimSId;
        private int reclaimMId;

    public Reclamation() {
        // Constructeur par défaut
    }

    public Reclamation(String reclaimType, String reclaimDescription, String reclaimStatus, String date,String reclaimResolutionDate, int reclaimSId, int reclaimMId) {
        this.reclaimType = reclaimType;
        this.reclaimDescription = reclaimDescription;
        this.date=date;
        this.reclaimStatus = reclaimStatus;
        this.reclaimResolutionDate = reclaimResolutionDate;
        this.reclaimSId = reclaimSId;
        this.reclaimMId = reclaimMId;
    }

        // Getters and Setters
public String getDate(){
        return date;
}
public void setDate(String date){
        this.date = date;
}
        public int getReclaimId() {
            return reclaimId;
        }

        public void setReclaimId(int reclaimId) {
            this.reclaimId = reclaimId;
        }

        public String getReclaimType() {
            return reclaimType;
        }

        public void setReclaimType(String reclaimType) {
            this.reclaimType = reclaimType;
        }

        public String getReclaimDescription() {
            return reclaimDescription;
        }

        public void setReclaimDescription(String reclaimDescription) {
            this.reclaimDescription = reclaimDescription;
        }

        public String getReclaimStatus() {
            return reclaimStatus;
        }

        public void setReclaimStatus(String reclaimStatus) {
            this.reclaimStatus = reclaimStatus;
        }

        public String getReclaimResolutionDate() {
            return reclaimResolutionDate;
        }

        public void setReclaimResolutionDate(String reclaimResolutionDate) {
            this.reclaimResolutionDate = reclaimResolutionDate;
        }

        public int getReclaimSId() {
            return reclaimSId;
        }

        public void setReclaimSId(int reclaimSId) {
            this.reclaimSId = reclaimSId;
        }

        public int getReclaimMId() {
            return reclaimMId;
        }

        public void setReclaimMId(int reclaimMId) {
            this.reclaimMId = reclaimMId;
        }
    }

