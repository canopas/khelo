"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MailRepository = void 0;

class MailRepository {
  constructor(db) {
    this.db = db;
  }

  htmlTemplate(data) {
    return `
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
      <meta name="HandheldFriendly" content="true">
      <style>
        table {
          width: 80%;
          border-collapse: collapse;
        }

        table, th, td {
          border: 1px solid black;
        }

        th {
          font-weight: bold;
        }

        th, td {
          height: 30px;
          text-align: center;
        }
      </style>
    </head>
    <body>
      <br>
      <table>
        <tbody>
          ${Object.entries(data).map(([key, value]) => {
      // Handling arrays for multi-line values
      const formattedValue = Array.isArray(value) ? value.join("</p><p>") : value;
      return `<tr><td>${key}</td><td>${formattedValue}</td></tr>`;
    }).join('')}
        </tbody>
      </table>
    </body>
    </html>
  `;
  }

  async sendSupportRequest(data) {
    const htmlTemplate = this.htmlTemplate(data);

    return await this.db.collection("support_requests")
      .add({
        to: ["sidhdhi.p@canopas.com", "mayank.v@canopas.com"],
        message: {
          subject: "Report problem",
          html: htmlTemplate,
        },
      }).then(() => console.log("Queued email for delivery!"));
  }

}

exports.MailRepository = MailRepository;