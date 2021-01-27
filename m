Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31A73056A0
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 10:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhA0JQM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jan 2021 04:16:12 -0500
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:38357
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235139AbhA0JOC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 27 Jan 2021 04:14:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LohmYt2zLd6lFmmvKhQ3nC19chbP1WVOdEH3FsMCbR6gp2uTp5RexPF/+k+WImCBDim0rf+RQz8/NepwMDbjfg2cLLQS8f8UJnYyQOucJKIKbjhfWpmLBhVmK52ttQT0KUPlL+tKQcf4kxJXcAK4jxG1Yhv9WAULXqgtCdVOVN5LLFbYrqn0QXC0w1WPy7FyMzp57jQSN2f93/T3d/LZ8feBqBoI2xFBLDlUKyHy/DjZeb+OlDSmEjKj050+eRrHMGC8zDCas/iAqejsbqiQk1m4aaxLYDCgAM2Qf4coFAkTxfE2f0JIWfcDqIkaaUPEm6HYSgqLapqcQy+N77upcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpUXPHHejkMZch0Ue7H+fUos5ht1izOazQ2shcfH1Fo=;
 b=GZ7QTOYOn5sXEKSFVNC1101dBl6vII8Qys1V98V1tbeSHHgkIxfOsYhlskx1NTEeL+FoOroWJd+wvp3qk/3wUEqfMhBmxo6aXEYMTfpPp2aDfFOuRuEmfV0skz1iiJcpHvPMISovj15hGelHaI0cwCg5O6i/sBfWEn0MyJlkDBBPjJpThSWgG1LLiDZGh/OmirqVIKfo9fJLfF4pF7PlWUcmhs5DS4WGdEdLqoaOP8DFsDkblKPYnVIjoeh5aSRZUgTHfwohYiDw6vkTV8bPk202zgGKIiQc+Ed4Z944dgJC1rit9hPflyqpMVJOq8ZLd98lTEIXIq+ZsHX9RBhJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpUXPHHejkMZch0Ue7H+fUos5ht1izOazQ2shcfH1Fo=;
 b=PpRTboLm1UbzZCjrVrGZBXnmZdez5k8glAw1utXsPYputt9zXaaG/o1FLSVRVr7d5ll/Qaya9cT5vcRCGKqY0g1xgMW2S5BVUqvsWy71tkSrQUkUdKrPBMZ3E903PCi/DqU49gZo6dnUP7126Qspiq8d2eVSADmsB7GWYfGIbRg=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB2381.namprd02.prod.outlook.com (2603:10b6:300:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 09:13:06 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942%3]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 09:13:06 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
Thread-Topic: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
Thread-Index: AQHW7UWZwDiwSbkqzUWMwmmZwUyntqozISAAgAgZmKA=
Date:   Wed, 27 Jan 2021 09:13:06 +0000
Message-ID: <MWHPR02MB2623B63A5359BB35B89BF086C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210118025058.10051-1-nava.manne@xilinx.com>
 <YApf1jlEghbnDFo/@archbook>
In-Reply-To: <YApf1jlEghbnDFo/@archbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cef5470f-ecb8-49aa-ece3-08d8c2a3c1eb
x-ms-traffictypediagnostic: MWHPR02MB2381:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2381DF63744BEAB32807104EC2BB9@MWHPR02MB2381.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2bdy+VEABgmcEHN5WePQMgVPvnys0/uZ7zm3pOAIsAA0WyhpzJjgiDeO9SU6X/EJAkB66EcfJUUxKsh5UEUidEqOOIvhExOfOX4bAfoIM7uBx4yxqGP1mu/C1VVEBD9PqiS+Y+FruzvY+wvesw1GKaBpW0IOIk1lokgHgylP4uNyUFFj6VgSh8ckEh3IaSEUOBrNrWdmfZovXOz/i4zN4oD11CiOZdTaNKkJt2CgQIjBtwKWuXzXbxZ1uVd5CF6m0/5JVrFU/dFxotbowcoY3aQQ/O/qmgDkHf3LlzSQQKRXrke2Bm7ru5WvU4KUVabBY0rd8kLsCXOw2KswQgBegx1JjlxAf4kPaaFF0v/A5zA5QwJ5IlSde0gd87TFvltYYpPUhHcuiCFbVSqM+fJiZ+jC0EStMYxSoMN1wsx7p+aH+6uIjfXYijOfdMz0oa+8aPKWoCAY9poHVQHJQzeOC33/qJm4eKpRjf9JFuweYgOD45Ez9PGIdbek82Grn72sgfzStm6U2Jg5ps1qOJYi3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(83380400001)(66446008)(66476007)(478600001)(66946007)(76116006)(66556008)(7696005)(64756008)(33656002)(6506007)(186003)(6916009)(26005)(4326008)(8676002)(8936002)(5660300002)(2906002)(53546011)(52536014)(86362001)(54906003)(55016002)(316002)(71200400001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jFRuOpIE15nAbr9TU1rkn2NFWPG3xCRgto5owftopY74DaqaChMVtP9z4ulC?=
 =?us-ascii?Q?/Js74avefxdbFU42qVWEnjgjhplgMRrLQ8XVAzSUGigvCVXIsQmmQ/G6xyg7?=
 =?us-ascii?Q?tzUKThL3hU3hx7/FY9WT5uMYdtPMbNjMTle1GcWFZirwihNBZwhmCH1DxRHT?=
 =?us-ascii?Q?BxmOuk4h0gQyuVu0DpjX7Wk7qU5XcX5O9mSwl0F6HCxvrXIH01WvWDqpxD+f?=
 =?us-ascii?Q?2nnKR+T+6mjWe663aPqXzWjnweFpAkzKP1bqEcM0XRGPPSdklEMegjTRmwAs?=
 =?us-ascii?Q?mxiXbjDlqhV64g5ZO6NMFmQam/lD+dZtd3qmSnloDf+U1VfP0scUZ8J0m7W9?=
 =?us-ascii?Q?UPlQAL3yn+tTeIdoAe0B3R5gF9lgdW2SdV1+UrU4N2B8FRxCyNARYnymk4yH?=
 =?us-ascii?Q?enenhOn8A7EujTizOgR8iJcNEYZOIzB6a24oFWEhVWLJrrN7A2IJq5uaY25z?=
 =?us-ascii?Q?asVJv8Ll+v8EQ3khVqEhueH/gNgezsoTLJ8DHOcTPvI6E+X/VtFROP1nxApf?=
 =?us-ascii?Q?6HjWFXme2+1tW2dxObv/sq2lgVs87X/NKYserQ3oueIQ7oQV8Uoj2ifDI25H?=
 =?us-ascii?Q?GHhDeYmsS1QXYQUuh6dG0jQoiOci0A94hwqkbtqZXQRqg1UdnbkcsEYM015q?=
 =?us-ascii?Q?WhL48pCwD3NvKe1zri5LqpXQ9H1hBpTjeY4LPS+JNxyD4JnVEIun8UjkmHou?=
 =?us-ascii?Q?gmp7S41eO+pEUHqB6QZyRp97mcpu0rgcAHvZtc6sZgqyyVOTGdJYc/oao08e?=
 =?us-ascii?Q?tTHA8lZlRBUyAVFlI4RAk2EeIu7sqM4DepLuSvzrCM3gJv8vKxQTbj9nMAxJ?=
 =?us-ascii?Q?+DXEYIa+MwTQCED12nG2YmRKLSP5Fr79V4m4w/AH0ne8PGsibS9/usAaTMq3?=
 =?us-ascii?Q?BoAQd8AqNblmICTzsbBLIaHQL4r1e0CxdnoiTkZ9aykbSvPq8ah1zoOuZgRP?=
 =?us-ascii?Q?zzchKc5IH1VpvBdIC9a/Pb9//EhmkgKhnQZjaDtKn7Bg8etV7fAiq+jPDVi2?=
 =?us-ascii?Q?M/aFdy1R6IuzkU6PK2PCKLtwH7rMz06YCeVvuy1L6aXbEp5+z8dRRheSU6bd?=
 =?us-ascii?Q?xPlmeDEH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef5470f-ecb8-49aa-ece3-08d8c2a3c1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 09:13:06.0517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgR4wdS1jwAt28aRETVDew3QqXCX/zNJNQR3LU59hIw7lLOgdpge/d7jIUkDMBpWTwWvETV30oYXs5qLZwTCuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2381
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

	Thanks for the review.
Please find my response inline.

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Friday, January 22, 2021 10:47 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git <git@xilinx.com>; chinnikishore369@gmail.com
> Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
>=20
> On Mon, Jan 18, 2021 at 08:20:57AM +0530, Nava kishore Manne wrote:
> > This commit adds secure flags to the framework to support secure
> > BitStream Loading.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  drivers/fpga/of-fpga-region.c | 10 ++++++++++
> > include/linux/fpga/fpga-mgr.h | 12 ++++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/fpga/of-fpga-region.c
> > b/drivers/fpga/of-fpga-region.c index e405309baadc..3a5eb4808888
> > 100644
> > --- a/drivers/fpga/of-fpga-region.c
> > +++ b/drivers/fpga/of-fpga-region.c
> > @@ -228,6 +228,16 @@ static struct fpga_image_info
> *of_fpga_region_parse_ov(
> >  	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
> >  		info->flags |=3D FPGA_MGR_ENCRYPTED_BITSTREAM;
> >
> > +	if (of_property_read_bool(overlay, "userkey-encrypted-fpga-
> config"))
> > +		info->flags |=3D
> FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM;
>=20
> Can this just be encrypted-fpga-config/FPGA_MGR_ENCRYPTED?

In Encryption we have two kinds of use case one is Encrypted Bitstream load=
ing with Device-key and
Other one is Encrypted Bitstream loading with User-key. To differentiate bo=
th the use cases this
Changes are needed.

Regards,
Navakishore.
