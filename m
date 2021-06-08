Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDA439F594
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 13:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhFHLw0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 07:52:26 -0400
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:37222
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232145AbhFHLwZ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 8 Jun 2021 07:52:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ly1MbeVFKkFYxSRL7t4K8VkrDQxdQeX1MsHndrjxESjgkunWyyRa5DhwoQNRi00wWTStpE/JpT3H65vMvUTj+Bs/got+FOzh6LCaBNMxdjxpRsSCrK/9Sz/hy3X/cy/816GcT46I4vQrdXDPtZNOHGZ5h+shgOVFMrrx4ZDwkxZJZ/UCEafwqFiG6Z3E0VxYe4K6ynhFM+4l6aeCsXwvjGc91lzHEtrls/D1HaK3OABxhkWS9xi5m/zy+Y2Fu8YvaHk3d4Kejz6mF3Re9MeZiKqEOOdpwDwgbBzAsJKekomvwARfwc0VN2sEVasQts4CjAQXmMib/xaAEfs6QIBTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7jonI52DunPSP7W/A9zJErQjGOGppyysxE81vF9Jes=;
 b=TaA76QLORCUXQKvMg5PMS/cxH9QiOCQ5iKQ4rTDhoIWc/1hOcN/bp5GrC7pRxFDKZDpLazRuh7KSQU/Aps2wqHeXd2+zIZgz/58rZKESSn2SBTJVMFFfH6qRusPLDrUOYL0+Wp+9S1482qJojQEdT3MS4dxiFSWgmIu+36mms4YFTDjX8VWoKGJdP7701noTSab3uqvRYq6+46wL1OvBcAfmwuNuM+N6zhDQJcn4nqFF1tH3E6K1PzlU61b9AxhIq8B6xHhKNpraL6GDO3QRen0MjkwtnqZbYuKqDgdxMowd6GfWqCTaKxPzH3ObTnV7LmB+HhJP6k91vwEPGJxxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7jonI52DunPSP7W/A9zJErQjGOGppyysxE81vF9Jes=;
 b=Jn+RrAssXMIRoxG3mn2fd+57aGWrC9c0Dl0/E1P+prPm4MDaFeB3iCm9U1P2rmF6+35ffBvi1ccSm77VBgRWZn18wxUNzK0PRYX8QZu+rjhEXOarmU1Mgcw29PdTI83UDwWhAtBywuQ6qm98TRsYPOYLCw4KFeYjKOizDIyrMRI=
Received: from PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) by
 PH0PR02MB7127.namprd02.prod.outlook.com (2603:10b6:510:1b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Tue, 8 Jun 2021 11:50:29 +0000
Received: from PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e]) by PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e%9]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 11:50:29 +0000
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
Thread-Index: AQHW7UWZwDiwSbkqzUWMwmmZwUyntqozISAAgAgZmKCANxU1wIBrXauAgAFH0bCAGPoWwIAS7o2w
Date:   Tue, 8 Jun 2021 11:50:29 +0000
Message-ID: <PH0PR02MB73362D54B2957F1F2719579DC2379@PH0PR02MB7336.namprd02.prod.outlook.com>
References: <20210118025058.10051-1-nava.manne@xilinx.com>
 <YApf1jlEghbnDFo/@archbook>
 <MWHPR02MB2623B63A5359BB35B89BF086C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
 <BN6PR02MB2612733F9D85ED6A36BBF801C2989@BN6PR02MB2612.namprd02.prod.outlook.com>
 <YJlw5fk0ORhioDb4@epycbox.lan>
 <MWHPR02MB2623E6E6759FA574129901E7C2539@MWHPR02MB2623.namprd02.prod.outlook.com>
 <MW4PR02MB733201057C43C9EEC54EF255C2239@MW4PR02MB7332.namprd02.prod.outlook.com>
In-Reply-To: <MW4PR02MB733201057C43C9EEC54EF255C2239@MW4PR02MB7332.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0e5ccaa-2e7d-44c8-cc0e-08d92a739d44
x-ms-traffictypediagnostic: PH0PR02MB7127:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR02MB71279A98643F33FAA268003CC2379@PH0PR02MB7127.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CgogqwnxyaB2BoozcThCbWMYUvoDZuibVGBsZ+81WrM05H0B6/wgLg8eVQVArhXKnkeU3Ln/vv1BEuuXSO8uBxS3hEGWw/4KDxw5bepy8peWwCWwUzS0VuIui5GR1uSlv8byt2UfjsXgNvQEOUFGvmXAtotqOsPC+ZS9CC9jcAR+SQR5yB3nmWPCrhT97CFXY8Doi/RRUsltfGzzBsUoHXoLJ472EhQoaOU5Q+0gsx0TY4IvZ3TkMxQWx3Z2n30GrMIYL8vfFl6WAJV1R+RXVxaJxeP9tPsIQyYfsFWBbYTRta1Yc34XZFiPdBk1OOdQv0mUDEum9K3S+0AYAZU+iYqRN0EE8ADiFf+X7BcjSTWTMx9Mghqn54XaKrKOb5g3oYKZv8J96fEcAfPzEs52oS+jIrS/03FXT+PR+k73LhZ41Eql1Xi1n7PmIEjgO4hZZF3FytZPI2MndEYZR/CEjpVnwFaoRgFeQETjoQmuDRs2+kFz0raevvjW+RU7UCKuSse7W10Y7fV6QnGqZbVF52kD/OPRtIfor4BexCOnbXNR9oAuG6o36spLFOKXsNmaNsafV+hsgM9hM54rR/lm5RHkJKFacDoBIIV8S1c84TQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7336.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(376002)(366004)(346002)(316002)(26005)(54906003)(6916009)(66446008)(38100700002)(55016002)(122000001)(66946007)(66476007)(76116006)(64756008)(66556008)(7696005)(478600001)(6506007)(2906002)(53546011)(8676002)(8936002)(71200400001)(4326008)(9686003)(5660300002)(33656002)(83380400001)(186003)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kiVmy/pxDvsTFROGBXipGByg7JkjUKRxZXWbt5rgyxk48Fkh744zn1wx7RQj?=
 =?us-ascii?Q?nQ47Tq7q9LB1c7VBVCfR7NXOFjBf62cA3GlccoiiGq+bmmYaKDxTsZFcNtiC?=
 =?us-ascii?Q?gRRvNcpqcNOvEqk/lCEiEVR3daYTdTTpfS5X0NaaguW4JKQ0bGwCCEJncrAg?=
 =?us-ascii?Q?4+5X8HzSE+9LxHBW/s6TkIKyOYPhvQoIePUbBl5Jgv38uLhBn5f+Q1HqFDlh?=
 =?us-ascii?Q?Va/bqtCT+vD0uS0SiOgMF2jjB1SSUJnHZwZO1B2Ms3uWDz4TUphr87mC21v/?=
 =?us-ascii?Q?uecpxFaBSgEM2WL6xiZIejoD0E1fXyyv2gT4auO2Rg4YghX7C+8/nzisW+cj?=
 =?us-ascii?Q?7SPt1s3QL6uBv60M4VWjhyNzP1vGIRwQ186+euIHK1zFZ9nPATk+xq+S2ywU?=
 =?us-ascii?Q?grM2s1TWT2kTjNAM5iXhpfinSJ+J91Wc2Ht+cEm1kxZzypi0w+sxpo75Y598?=
 =?us-ascii?Q?TF1IDr0+npz9GKhEZhWpAbwdJyJ40+Rnu9vvcT1+IHdXbtM8bx8z2OLrQPeZ?=
 =?us-ascii?Q?9d+Kgn3zKQ7sVEAnTUeI+NucUurVaU3J7V+O+SzSER9hc3SVREtfL0SScaCQ?=
 =?us-ascii?Q?TOge0VNDzFGIzWQM3eRGYVb8zTlITsikh+glvY3WiEADrK0JxnxLQszGD9Vg?=
 =?us-ascii?Q?24B87WUpGzMU3Y3RCY1SKe2bON54W+Uz0X4cs8zDyY5VcIwh/Ls0hecuj5mV?=
 =?us-ascii?Q?ufkN4ivJv9menOb7BtqaRK7QDn50IP8HNvgUzzKwjVDPvhaU28kMv+rIX11w?=
 =?us-ascii?Q?iDS0xSF3l0G/WyE+rFVLtxYAPwLPEWIEA1HZlpwGpqN51AU2zUrjySSyxxKz?=
 =?us-ascii?Q?XIxxFL9/Dwou66baVXTVd3zX8/b2I+fgWHTca5/3LKeecbYsqxMKifT+6dnj?=
 =?us-ascii?Q?KpUWB7NKzgwrxpA0ZbvR+0uEQd6wji9Pny7lYneoW0LwbKbuwR6zXY6whEQo?=
 =?us-ascii?Q?EhQrjfh4K9eW2NlasFAxN7mpHN56QeNrKilMRKKpXVcLW+KT+W5DJK0h7zmD?=
 =?us-ascii?Q?ilVG0FkSm8igWRMTQnucjwSY8azSPOFvyLgFBXsRvhc9Qf+W8UcHN1KSwWOO?=
 =?us-ascii?Q?X8g4wlvoIMMBGqPTkz9cLvTq8SPbiRAPMfU1RTUcEoWxcawD9d+Vo2TyOG91?=
 =?us-ascii?Q?NhC47sxmHsTLPNIhV+LtrjDr2LKO+dBLQXhi7evJb1pU93sfwhzIBw82L6+S?=
 =?us-ascii?Q?248dfpE9HPFu1v3dOSHwjX9hjQ55sDgoGEc/S65cpU1jRsF/sL/ukmIeGY4Q?=
 =?us-ascii?Q?BWI2X1XjBWqMtw9d97Pqs+tRyCaNnbUTUqjjMZu0fnuS0zPig83AIoN7UzX4?=
 =?us-ascii?Q?IIKiDsJ7TZVBmoXu/E3gNTn1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7336.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e5ccaa-2e7d-44c8-cc0e-08d92a739d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 11:50:29.6060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaE1aRsc/oTvHpviGZKGxnjbrqJsQ02wE95ZGHlTYuojt0fFCiTSnEIEgI0pE/1ljJBwewGqE1bcdNQ0lqC2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7127
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Ping!

> -----Original Message-----
> From: Nava kishore Manne <navam@xilinx.com>
> Sent: Thursday, May 27, 2021 4:14 PM
> To: Moritz Fischer <mdf@kernel.org>
> Cc: trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git <git@xilinx.com>; chinnikishore369@gmail.com
> Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
>=20
> Ping!
>=20
> > -----Original Message-----
> > From: Nava kishore Manne <navam@xilinx.com>
> > Sent: Tuesday, May 11, 2021 7:02 PM
> > To: Moritz Fischer <mdf@kernel.org>
> > Cc: trix@redhat.com; robh+dt@kernel.org; Michal Simek
> > <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > chinnikishore369@gmail.com
> > Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading
> > support
> >
> > Hi Moritz,
> >
> > Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Moritz Fischer <mdf@kernel.org>
> > > Sent: Monday, May 10, 2021 11:14 PM
> > > To: Nava kishore Manne <navam@xilinx.com>
> > > Cc: Moritz Fischer <mdf@kernel.org>; trix@redhat.com;
> > > robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> > > fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> > > <git@xilinx.com>; chinnikishore369@gmail.com
> > > Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading
> > > support
> > >
> > > On Wed, Mar 03, 2021 at 10:11:51AM +0000, Nava kishore Manne wrote:
> > > > Ping!
> > > >
> > > > > -----Original Message-----
> > > > > From: Nava kishore Manne
> > > > > Sent: Wednesday, January 27, 2021 2:43 PM
> > > > > To: Moritz Fischer <mdf@kernel.org>
> > > > > Cc: trix@redhat.com; robh+dt@kernel.org; Michal Simek
> > > > > <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > > > > devicetree@vger.kernel.org;
> > > > > linux-arm-kernel@lists.infradead.org;
> > > > > linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > > > > chinnikishore369@gmail.com
> > > > > Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream
> > > > > loading support
> > > > >
> > > > > Hi Moritz,
> > > > >
> > > > > 	Thanks for the review.
> > > > > Please find my response inline.
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Moritz Fischer <mdf@kernel.org>
> > > > > > Sent: Friday, January 22, 2021 10:47 AM
> > > > > > To: Nava kishore Manne <navam@xilinx.com>
> > > > > > Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org;
> > > > > > Michal Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > > > > > devicetree@vger.kernel.org;
> > > > > > linux-arm-kernel@lists.infradead.org;
> > > > > > linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > > > > > chinnikishore369@gmail.com
> > > > > > Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream
> > > > > > loading support
> > > > > >
> > > > > > On Mon, Jan 18, 2021 at 08:20:57AM +0530, Nava kishore Manne
> > > wrote:
> > > > > > > This commit adds secure flags to the framework to support
> > > > > > > secure BitStream Loading.
> > > > > > >
> > > > > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > > > > ---
> > > > > > >  drivers/fpga/of-fpga-region.c | 10 ++++++++++
> > > > > > > include/linux/fpga/fpga-mgr.h | 12 ++++++++++++
> > > > > > >  2 files changed, 22 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/fpga/of-fpga-region.c
> > > > > > > b/drivers/fpga/of-fpga-region.c index
> > > > > > > e405309baadc..3a5eb4808888
> > > > > > > 100644
> > > > > > > --- a/drivers/fpga/of-fpga-region.c
> > > > > > > +++ b/drivers/fpga/of-fpga-region.c
> > > > > > > @@ -228,6 +228,16 @@ static struct fpga_image_info
> > > > > > *of_fpga_region_parse_ov(
> > > > > > >  	if (of_property_read_bool(overlay, "encrypted-fpga-config")=
)
> > > > > > >  		info->flags |=3D FPGA_MGR_ENCRYPTED_BITSTREAM;
> > > > > > >
> > > > > > > +	if (of_property_read_bool(overlay,
> > > > > > > +"userkey-encrypted-fpga-
> > > > > > config"))
> > > > > > > +		info->flags |=3D
> > > > > > FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM;
> > > > > >
> > > > > > Can this just be encrypted-fpga-config/FPGA_MGR_ENCRYPTED?
> > > > >
> > > > > In Encryption we have two kinds of use case one is Encrypted
> > > > > Bitstream loading with Device-key and Other one is Encrypted
> > > > > Bitstream loading with User-key. To differentiate both the use
> > > > > cases this
> > > Changes are needed.
> > > > >
> > > > > Regards,
> > > > > Navakishore.
> > >
> > > Is this region specific, or could this be a sysfs attribute?
> > >
> >
> > These changes are region specific.
> >
> > Regards,
> > Navakishore.

