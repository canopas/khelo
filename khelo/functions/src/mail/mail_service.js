"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MailService = void 0;

class MailService {
    constructor(db) {
        this.db = db;
    }
    async sendMail(data) {
        return await this.db.collection('support_requests')
            .add({
                to: ["sidhdhi.p@canopas.com", "mayank.v@canopas.com"],
                template: {
                    name: "support_request",
                    data: {
                        request: data
                    },
                },
            }).then(() => console.log('Queued email for delivery!'));
    }

}

exports.MailService = MailService;