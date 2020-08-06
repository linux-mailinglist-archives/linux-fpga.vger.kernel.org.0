Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4E23DEFE
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Aug 2020 19:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgHFRfz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Aug 2020 13:35:55 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3676 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730566AbgHFRfs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Aug 2020 13:35:48 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076DlZmq011427;
        Thu, 6 Aug 2020 09:49:26 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 32n6ck15m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 09:49:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRMijnGT7e1zqMedy0fXFSEee8DkWpfqXV2tdH0rowLXwX8cO9hlJRNZSaa2GUkIR2z/e0C2P9GJU1WdUwnxf5owy91Oz6N0Rd0DO9sOYzVpTB2hUZQ9NVcZpIfCjBOHefs6phOgVBmKJbQOYsZ0nLISpShfRvvjvzbgBSCD9NPWRBLKbDutJjQRbewjRr8dJLlqHSACpRMAd2NfZrHqn4rUuWGrS6utmX7Q248ovO0wOH7gxGaxKf9xhWQMM1JBoRhruStpDFN/A8ew/bdTa3AQvfFJfl1Q14ERA8tNxG+4woMmI9QFyCbzGEWwaS2mrM9gA7sqmkdRNHovCJEVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOM7NM1iJ26M3YdgHo3UVATfJ9MTnZZ4o6hjYJ6lTs4=;
 b=itNIezByrv7pl8l66dC3JzxWz/JR+uqgu8eW9ON0LTTFKEt+yL6neQAzwDp3aUtJC6EM4e6fHy0oU1HQl0VS9zbPLGmliyPG43YsX/OBHk4Xrpn7geGU0IgHL+UJt8fZabhKMJv8GwJtiMQsaA3JMWatYilO/d7Bl1FNRStleuvUFHQCl3LlHRrtymR07MCRsFaqXVZn3uw8gvgiGL4wTAIOujn2DB0rBI87hapn335BXJSLrsR7BlA67XQIRzs/EokSpszJO8wNiAQ6XGQEteQUzzagK9ailzXWjrM/hurMU8D2PELs3ZOQZfH0RY0CF6MKY5kIszrBFft526I1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOM7NM1iJ26M3YdgHo3UVATfJ9MTnZZ4o6hjYJ6lTs4=;
 b=NV5uappU/PCGoyUNvKCcxihPM07a/c4D7C0lm/1MFlKV8QN6Eb5hisfOFLdo6VPuruBHQWI6P3exvWHZ1ufueNKWrRVseuqa+JiiG4TpIinkZ6b7n17QTAC+89ZJmxR8YTbuWptX/axqJD/tkIPl7N/ItoyDFFQuS0kQd1ODnAY=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5131.namprd03.prod.outlook.com (2603:10b6:5:1f0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Thu, 6 Aug
 2020 13:49:24 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e97d:30de:ae7d:6257]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e97d:30de:ae7d:6257%4]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 13:49:24 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Tom Rix <trix@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
Subject: RE: [PATCH 5/6] include: fpga: adi-axi-common.h: add definitions for
 supported FPGAs
Thread-Topic: [PATCH 5/6] include: fpga: adi-axi-common.h: add definitions for
 supported FPGAs
Thread-Index: AQHWak82lAuBItcnNUGP16B6HmVxh6kpru4AgAFaFjA=
Date:   Thu, 6 Aug 2020 13:49:23 +0000
Message-ID: <DM6PR03MB4411223ACCDE31C07838C988F9480@DM6PR03MB4411.namprd03.prod.outlook.com>
References: <20200804110658.40911-1-alexandru.ardelean@analog.com>
 <20200804110658.40911-6-alexandru.ardelean@analog.com>
 <f69c3dc7-be50-9685-b70f-8af2f7093646@redhat.com>
In-Reply-To: <f69c3dc7-be50-9685-b70f-8af2f7093646@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVdGeVpHVnNaV0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB6T1RnNU5tVmhNQzFrTjJVekxURXhaV0V0WVRrM09DMWtOREkx?=
 =?utf-8?B?T0dKbFlUWmhZbVJjWVcxbExYUmxjM1JjTXprNE9UWmxZVEl0WkRkbE15MHhN?=
 =?utf-8?B?V1ZoTFdFNU56Z3RaRFF5TlRoaVpXRTJZV0prWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpPVFV3SWlCMFBTSXhNekkwTVRFNU1UYzFNakl4TVRBeU9UTWlJR2c5SW05?=
 =?utf-8?B?UE4xWk5SRzFWU1hoT2IzTlJPRXd2WW5jeFFuSTVNRXhSVVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWxaQ0t5ODNOekoyVjBGVksxRmlVVVZ2VWtOamJW?=
 =?utf-8?B?UTFRblJCVTJoRlNubFpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlUyeEdLMFpSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: true
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.24.35.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 215bec75-a0ee-4f6b-307c-08d83a0f8735
x-ms-traffictypediagnostic: DM6PR03MB5131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB51317C816FBCA436FC0097B5F9480@DM6PR03MB5131.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6TBZJdWkrJqqBPVIASXWM+M6t2A0zPzcFBcosVHciohk6B5QyLUR74se1Kyyh0AOGwj9zU6sugMziw6eQ6ldLNVdUkUX4koExRXEvKrvfm2KTpSjn2L5SRkm21PFiPjkED2hN7lirIjSImdkWYhG2OjMl1aPpUw7MKjSB2OmAO9EuBjI4d0rkIVrSfL72QCZHrn+N2euBCxoxCM5xpLv+VdrlwV2e4Gl3T9t6DcOtheBzK1NwzHtlgC6DJDAACHrH6nNCj86EkzllNPXBZtX5ZWaNTPNbIoB2kLWNM5AlsW8NobhjPiIGadCOGikXmCe3rGgT3nLbjituHjd0LRq/dayPzSFgXPj8cxD4+Ya1HdB5mW58S+ze9QuuZP+LkRTp2v1szLtJCpXlRtF0ptrUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(7696005)(966005)(316002)(4326008)(110136005)(8936002)(478600001)(71200400001)(8676002)(107886003)(54906003)(26005)(52536014)(186003)(2906002)(66946007)(83380400001)(9686003)(66476007)(66556008)(64756008)(66446008)(6506007)(86362001)(5660300002)(76116006)(55016002)(33656002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MDdtharVZXgW8OQMmRekqg7Tlu9rQRQ4CVJ9VKl1YerHah8A4WJITRy89DDgR+CcKj8tjjHPJuNIoQPqEPeWOiT1Ku0vdTTRh+60cIIpHr1h8dTeGrd8981vJ+F5kysUOXd5Rq/ng8spMoPKQaBT1Ae2W10EGKKYxujngF7n+YvFKxLZ1EGfq2JiEiFc0YsSovK+M4HRhQaCddEY21ZTcKnbZm5QnXIqjGBi7njUeCg8qtV/RLLAUztbvjdFlx0+eY2jvhGBhtlkpFCf0dNdwTQH7VquizlTK8rEAsFESoVaHWJ2QD6tQqiM7dWYVAjIIktf8GQ+wKPVoVOXiIUXf8xEHZR28CWzYL8GEGEOFyR6hL07ZICQyX8hVsX/29xTwlBr3H7PHQgPczUVGGlIM3xWeoroUaj1de0qOvDLhLra7cZJcV339/hjgkY6ERzAwem/QVTR/W7UC9loh+SO2QKCdk7h6V4aNN/mzQn9JUGcJEDVlvBCSYiRNqc5TYrHRLArwPV6brXcSlgAfbM6SEgKuxw2xErUCfgWCZIeXLWV0y7EjXOKioIwhAYyeTveTF2qh5J6vk3rme0CSquMUstcoSSAwxu63oqX0NInwSb2lIIWGzBhoC3VfMCSj+p7/uHbkY6ZjAHM5cOAmKHmSw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215bec75-a0ee-4f6b-307c-08d83a0f8735
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 13:49:23.9675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPQhNAREcog2J/Uqc6XE/tc4vUzBe4i286RrHGNG+9QI1ucDHqhzEpzXxS0x4HXdPfw+8IMS6tI+tuENEttkk249gt10k8rG/N+2BvrNhyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5131
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_09:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060097
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFRvbSBSaXggPHRyaXhAcmVkaGF0LmNv
bT4gDQpTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA1LCAyMDIwIDc6MDIgUE0NClRvOiBBcmRlbGVh
biwgQWxleGFuZHJ1IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT47IGxpbnV4LWNsa0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQpDYzogbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNib3lkQGtlcm5l
bC5vcmc7IG1kZkBrZXJuZWwub3JnOyBDYXByaW9ydSwgTWlyY2VhIDxNaXJjZWEuQ2FwcmlvcnVA
YW5hbG9nLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggNS82XSBpbmNsdWRlOiBmcGdhOiBhZGkt
YXhpLWNvbW1vbi5oOiBhZGQgZGVmaW5pdGlvbnMgZm9yIHN1cHBvcnRlZCBGUEdBcw0KDQpbRXh0
ZXJuYWxdDQoNCg0KT24gOC80LzIwIDQ6MDYgQU0sIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToN
Cj4gRnJvbTogTWlyY2VhIENhcHJpb3J1IDxtaXJjZWEuY2FwcmlvcnVAYW5hbG9nLmNvbT4NCj4N
Cj4gQWxsIChuZXdlcikgRlBHQSBJUCBjb3JlcyBzdXBwb3J0ZWQgYnkgQW5hbG9nIERldmljZXMs
IHN0b3JlIA0KPiBpbmZvcm1hdGlvbiBpbiB0aGUgc3ludGhlc2l6ZWQgZGVzaWducy4gVGhpcyBp
bmZvcm1hdGlvbiBkZXNjcmliZXMgDQo+IHZhcmlvdXMgcGFyYW1ldGVycywgaW5jbHVkaW5nIHRo
ZSBmYW1pbHkgb2YgYm9hcmRzIG9uIHdoaWNoIHRoaXMgaXMgDQo+IGRlcGxveWVkLCBzcGVlZC1n
cmFkZSwgYW5kIHNvIG9uLg0KPg0KPiBDdXJyZW50bHksIHNvbWUgb2YgdGhlc2UgZGVmaW5pdGlv
bnMgYXJlIGRlcGxveWVkIG1vc3RseSBvbiBYaWxpbnggDQo+IGJvYXJkcywgYnV0IHRoZXkgaGF2
ZSBiZWVuIGNvbnNpZGVyZWQgYWxzbyBmb3IgRlBHQSBib2FyZHMgZnJvbSBvdGhlciB2ZW5kb3Jz
Lg0KPg0KPiBUaGUgcmVnaXN0ZXIgZGVmaW5pdGlvbnMgYXJlIGRlc2NyaWJlZCBhdCB0aGlzIGxp
bms6DQo+ICAgaHR0cHM6Ly93aWtpLmFuYWxvZy5jb20vcmVzb3VyY2VzL2ZwZ2EvZG9jcy9oZGwv
cmVnbWFwDQo+ICh0aGUgJ0Jhc2UgKGNvbW1vbiB0byBhbGwgY29yZXMpJyBzZWN0aW9uKS4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogTWlyY2VhIENhcHJpb3J1IDxtaXJjZWEuY2FwcmlvcnVAYW5hbG9n
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJk
ZWxlYW5AYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2ZwZ2EvYWRpLWF4aS1j
b21tb24uaCB8IDM3IA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvZnBnYS9hZGktYXhpLWNvbW1vbi5oIA0KPiBiL2luY2x1ZGUvbGludXgvZnBnYS9hZGktYXhp
LWNvbW1vbi5oDQo+IGluZGV4IDE0MWFjM2YyNTFlNi4uN2NjYTJkNjJjYzQ1IDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L2ZwZ2EvYWRpLWF4aS1jb21tb24uaA0KPiArKysgYi9pbmNsdWRl
L2xpbnV4L2ZwZ2EvYWRpLWF4aS1jb21tb24uaA0KPiBAQCAtMTMsNiArMTMsOSBAQA0KPiAgDQo+
ICAjZGVmaW5lIEFESV9BWElfUkVHX1ZFUlNJT04JCQkweDAwMDANCj4gIA0KPiArI2RlZmluZSBB
RElfQVhJX1JFR19GUEdBX0lORk8JCQkweDAwMUMNCj4gKyNkZWZpbmUgQURJX0FYSV9SRUdfRlBH
QV9WT0xUQUdFCQkweDAxNDANCj4gKw0KPiAgI2RlZmluZSBBRElfQVhJX1BDT1JFX1ZFUihtYWpv
ciwgbWlub3IsIHBhdGNoKQlcDQo+ICAJKCgobWFqb3IpIDw8IDE2KSB8ICgobWlub3IpIDw8IDgp
IHwgKHBhdGNoKSkNCj4gIA0KPiBAQCAtMjAsNCArMjMsMzggQEANCj4gICNkZWZpbmUgQURJX0FY
SV9QQ09SRV9WRVJfTUlOT1IodmVyc2lvbikJKCgodmVyc2lvbikgPj4gOCkgJiAweGZmKQ0KPiAg
I2RlZmluZSBBRElfQVhJX1BDT1JFX1ZFUl9QQVRDSCh2ZXJzaW9uKQkoKHZlcnNpb24pICYgMHhm
ZikNCj4gIA0KPiArI2RlZmluZSBBRElfQVhJX0lORk9fRlBHQV9WT0xUQUdFKHZhbCkJCSgodmFs
KSAmIDB4ZmZmZikNCj4gKw0KPiArI2RlZmluZSBBRElfQVhJX0lORk9fRlBHQV9URUNIKGluZm8p
CQkoKChpbmZvKSA+PiAyNCkgJiAweGZmKQ0KPiArI2RlZmluZSBBRElfQVhJX0lORk9fRlBHQV9G
QU1JTFkoaW5mbykJCSgoKGluZm8pID4+IDE2KSAmIDB4ZmYpDQo+ICsjZGVmaW5lIEFESV9BWElf
SU5GT19GUEdBX1NQRUVEX0dSQURFKGluZm8pCSgoKGluZm8pID4+IDgpICYgMHhmZikNCj4gKw0K
PiArZW51bSBhZGlfYXhpX2ZncGFfdGVjaG5vbG9neSB7DQoNCj4gZW51bSB0eXBlcyBhcmUgZGVm
aW5lZCBidXQgbm90IHVzZWQuwqAgSXQgd291bGQgYmUgYmV0dGVyIHRvIGNvbnZlcnQgYWxsIG9m
IHRoZXNlIHRvICNkZWZpbmVzLg0KPg0KPiBUaGVzZSBhcmUgb25seSB0aGUgWGlsaW54IHZhbHVl
cy4gTmVlZCB0byBhZGQgdGhlIEludGVsIHZhbHVlcyBmcm9tDQoNCj4gaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0aHViLmNvbS9hbmFsb2dkZXZpY2VzaW5jL2hkbC9ibG9i
L21hc3Rlci9saWJyYXJ5L3NjcmlwdHMvYWRpX2ludGVsX2RldmljZV9pbmZvX2VuYy50Y2xfXzsh
IUEzTmk4Q1MweTJZIXRwTHhjbnB2Y2pGVkVZejBtZlJOVzAzZFlldC1pa2xrMnNfZUc0Rm1SbWV5
TU9jbGRkOGYtenBlYkI1Tm5KTE9qbDFyTnckIA0KDQo+ICBUaGUgI2RlZmluZSBuYW1lcyBuZWVk
IHRvIGluY2x1ZGUgWElMSU5YIG9yIElOVEVMLg0KDQpBaCwgZ29vZCBwb2ludC4NClRoaXMgcGF0
Y2ggd2FzIGluaXRpYWxseSB3cml0dGVuIGJlZm9yZSB0aGUgSW50ZWwgc3R1ZmYgd2FzIGFkZGVk
Lg0KV2lsbCB1cGRhdGUuDQoNCkFwb2xvZ2llcyBmb3IgdGhlIG1pcy1mb3JtYXR0ZWQgcmVwbHkv
ZW1haWw7IHdpbGwgbmVlZCB0byBpbmNsdWRlIG15IEdtYWlsIGFjY291bnQgdG8gcmVwbHkgbmVh
dGVyIGhlcmUuDQoNCj4gIFRvbQ0KDQo+ICsJQURJX0FYSV9GUEdBX1RFQ0hfVU5LTk9XTiA9IDAs
DQo+ICsJQURJX0FYSV9GUEdBX1RFQ0hfU0VSSUVTNywNCj4gKwlBRElfQVhJX0ZQR0FfVEVDSF9V
TFRSQVNDQUxFLA0KPiArCUFESV9BWElfRlBHQV9URUNIX1VMVFJBU0NBTEVfUExVUywNCj4gK307
DQo+ICsNCj4gK2VudW0gYWRpX2F4aV9mcGdhX2ZhbWlseSB7DQo+ICsJQURJX0FYSV9GUEdBX0ZB
TUlMWV9VTktOT1dOID0gMCwNCj4gKwlBRElfQVhJX0ZQR0FfRkFNSUxZX0FSVElYLA0KPiArCUFE
SV9BWElfRlBHQV9GQU1JTFlfS0lOVEVYLA0KPiArCUFESV9BWElfRlBHQV9GQU1JTFlfVklSVEVY
LA0KPiArCUFESV9BWElfRlBHQV9GQU1JTFlfWllOUSwNCj4gK307DQo+ICsNCj4gK2VudW0gYWRp
X2F4aV9mcGdhX3NwZWVkX2dyYWRlIHsNCj4gKwlBRElfQVhJX0ZQR0FfU1BFRURfVU5LTk9XTgk9
IDAsDQo+ICsJQURJX0FYSV9GUEdBX1NQRUVEXzEJCT0gMTAsDQo+ICsJQURJX0FYSV9GUEdBX1NQ
RUVEXzFMCQk9IDExLA0KPiArCUFESV9BWElfRlBHQV9TUEVFRF8xSAkJPSAxMiwNCj4gKwlBRElf
QVhJX0ZQR0FfU1BFRURfMUhWCQk9IDEzLA0KPiArCUFESV9BWElfRlBHQV9TUEVFRF8xTFYJCT0g
MTQsDQo+ICsJQURJX0FYSV9GUEdBX1NQRUVEXzIJCT0gMjAsDQo+ICsJQURJX0FYSV9GUEdBX1NQ
RUVEXzJMCQk9IDIxLA0KPiArCUFESV9BWElfRlBHQV9TUEVFRF8yTFYJCT0gMjIsDQo+ICsJQURJ
X0FYSV9GUEdBX1NQRUVEXzMJCT0gMzAsDQo+ICt9Ow0KPiArDQo+ICAjZW5kaWYgLyogQURJX0FY
SV9DT01NT05fSF8gKi8NCg0K
